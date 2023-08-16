import 'package:espacenter_mobile/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/rezervacija.dart';
import '../models/termin.dart';
import '../providers/rezervacija_provider.dart';
import '../utils/util.dart';

class RezervacijaScreen extends StatefulWidget {
  Termin? termin;

  RezervacijaScreen({Key? key, this.termin}) : super(key: key);
  static const String routeName = "/rezervacija";

  @override
  State<RezervacijaScreen> createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  RezervacijaProvider? _rezervacijaProvider;
  List<Rezervacija> list = [];
  TerminProvider? _terminProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _terminProvider = context.read<TerminProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _rezervacijaProvider!.get({
      'korisnikID': Authorization.korisnik!.korisnikID,
      'isCanceled': false,
      'isCompleted': false,
      'includeTermin': true,
      'includeKorisnik': true,
      'includeUsluga': true
    });
     for (var rezervacija in tmpData) {
    if (rezervacija.termin!.isDeleted!) {
      Map updateRezervacija = {
        "korisnikID": rezervacija.korisnikID,
        "terminID": rezervacija.terminID,
        "uslugaID": rezervacija.uslugaID,
        "isCanceled": true,
        "isCompleted": false,
      };
      await _rezervacijaProvider!.update(rezervacija.rezervacijaID!, updateRezervacija);
    }
  }
    
    setState(() {
      list = tmpData;
    });
  }
  

  Future<void> updateTerminIsBooked(Termin item) async {
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(item.datumTermina!);
    Map update = {
      "korisnikID": item.korisnikID,
      "isBooked": false,
      "vrijemeTermina": item.vrijemeTermina,
      "datumTermina" : formattedDate
    };

    await _terminProvider!.update(item.terminID!, update);
  }

 

  Widget _buildRezervacijeCard(Rezervacija item) {
  return ListTile(
    leading: IconButton(
      onPressed: () async {
        
          Map updateTermin = {
            "korisnikID": item.termin!.korisnikID,
            "isBooked": false,
            "vrijemeTermina": item.termin!.vrijemeTermina,
            "datumTermina": DateFormat('yyyy-MM-ddTHH:mm:ss').format(item.termin!.datumTermina!)
          };
  
          await _terminProvider!.update(item.termin!.terminID!, updateTermin);
        
       
          Map updateRezervacija = {
            "korisnikID": item.korisnikID,
            "terminID": item.terminID,
            "uslugaID": item.uslugaID,
            "isCanceled": true,
            "isCompleted": false,
          };
  
          await _rezervacijaProvider!.update(item.rezervacijaID!, updateRezervacija);
  
       if (item.termin!.isDeleted!) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Termin je otkazan")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Rezervacija je otkazana")));
        }
          loadData();

      },
      icon: Icon(Icons.delete),
      iconSize: 40,
      color: Colors.red,
    ),
    title: Text("${formatDate(item.termin!.datumTermina!)}"),
    subtitle: Text(
        "Termin kod ${item.termin!.korisnik!.ime} ${item.termin!.korisnik!.prezime}"),
    trailing: Text("${item.termin!.vrijemeTermina}"),
  );
}

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje Rezervacije"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: _buildRezervacije(),
          )
        ]),
      ),
    );
  }

  Widget _buildRezervacije() {
    if (list.isEmpty) {
      return Center(
        child: Text("Trenutno nemate aktivnih rezervacija!"),
      );
    }

    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildRezervacijeCard(list[index]);
        },
      ),
    );
  }
}

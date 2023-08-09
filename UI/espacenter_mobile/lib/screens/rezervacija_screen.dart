import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/rezervacija.dart';
import '../providers/rezervacija_provider.dart';
import '../utils/util.dart';

class RezervacijaScreen extends StatefulWidget {
  const RezervacijaScreen({Key? key}): super(key: key);
  static const String routeName = "/rezervacija";

  @override
  State<RezervacijaScreen> createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  RezervacijaProvider? _rezervacijaProvider;
  List<Rezervacija> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _rezervacijaProvider!.get({
      'korisnikID': Authorization.korisnik!.korisnikID,
      'isCanceled': false,
      'isArchived':false,
      'includeTermin':true,
      'includeKorisnik':true,
      'includeUsluga':true
    });
    setState(() {
      list = tmpData;
    });
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

  Widget _buildRezervacijeCard(Rezervacija item) {
    return ListTile(
      leading: IconButton(
        onPressed: () async {
          Map update = {
            "korisnikID": item.korisnikID,
            "terminID": item.terminID,
            "uslugaID": item.uslugaID,
            "isCanceled": true,
            "isArchived": false
          };

          await _rezervacijaProvider!.update(item.rezervacijaID!, update);
          loadData();
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Rezervacija otkazana")));
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
}

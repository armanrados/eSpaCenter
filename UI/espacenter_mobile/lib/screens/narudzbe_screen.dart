import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/narudzba.dart';
import '../providers/narudzba_provider.dart';
import '../utils/util.dart';

class NarudzbeScreen extends StatefulWidget {
  const NarudzbeScreen({Key? key}): super(key: key);
  static const String routeName = "/narudzba";

  @override
  State<NarudzbeScreen> createState() => _NarudzbeScreenState();
}

class _NarudzbeScreenState extends State<NarudzbeScreen> {
  NarudzbaProvider? _narudzbaProvider;
  List<Narudzba> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _narudzbaProvider!.get({
      'korisnikID': Authorization.korisnik!.korisnikID,
      'isShipped': false,
      'isCanceled':false,
      'includeKorisnik':true,
      'includeNarudzbaProizvodi':true,
      'includeUplata':true
    });
    setState(() {
      list = tmpData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje Narudžbe"),
        backgroundColor: Color.fromARGB(255, 33, 103, 243),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: _buildNarudzbe(),
          )
        ]),
      ),
    );
  }

  Widget _buildNarudzbe()
  {
    if (list.isEmpty) {
      return Center(
        child: Text("Trenutno nemate aktivnih narudžbi"),
      );
    }

    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildNarudzbeCard(list[index]);
        },
      ),
    );
  }

   Widget _buildNarudzbeCard(Narudzba item) {
    return ListTile(
      leading: IconButton(
        onPressed: () async {
          Map update = {
            "isCanceled": true,
            "isShipped": false
          };

          await _narudzbaProvider!.update(item.narudzbaID!, update);
          loadData();
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Narudžba otkazana")));
        },
        icon: Icon(Icons.delete),
        iconSize: 30,
        color: Colors.red,
      ),
      title: Text("${item.brojNarudzbe}", style: TextStyle(fontSize: 14),),
      subtitle: Text(
          "Proizvodi: ${item.narudzbaProizvodi}"),
      trailing: Text("${item.ukupnaCijena} KM"),
    );
  }
}
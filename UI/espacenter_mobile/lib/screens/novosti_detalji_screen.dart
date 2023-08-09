import 'package:espacenter_mobile/models/korisnik.dart';
import 'package:espacenter_mobile/models/novosti.dart';
import 'package:espacenter_mobile/providers/korisnik_provider.dart';
import 'package:espacenter_mobile/providers/novosti_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class NovostiDetaljiScreen extends StatefulWidget {
  String id;
  static const String routeName = "/novosti_detalji";
  NovostiDetaljiScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<NovostiDetaljiScreen> createState() => _NovostiDetaljiScreenState();
}

class _NovostiDetaljiScreenState extends State<NovostiDetaljiScreen> {
  NovostiProvider? _novostiProvider;
  KorisnikProvider? _korisnikProvider;
  Novosti? _novosti;
  Korisnik? _korisnik;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _novostiProvider!.getById(int.parse(widget.id));
    var tmpKorisnik = await _korisnikProvider!.getById(tmpData.korisnikID!);
    setState(() {
      _novosti = tmpData;
      _korisnik = tmpKorisnik;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novost detalji"),
        backgroundColor: Color.fromARGB(255, 33, 103, 243),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [NovostDetalji()]),
        ),
      ),
    );
  }

  Widget NovostDetalji() {
    if (_novosti == null) {
      return Center(
        child: Text("Novost nema detalja!"),
      );
    } else {
      return 
         Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              // Add padding around the row widget
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: imageFromBase64String(_novosti!.slika!),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 20),
                          // Add a title widget
                          Text(_novosti?.naslov ?? "N/A",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),),

                          Container(height: 30),
                          // Add a text widget to display some text
                          Text(_novosti?.sadrzaj ?? "N/A",
                          style: TextStyle(
                            fontSize: 17,

                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(10),
              child : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
                
                children: [
                    Expanded(child: Text("Objavio: ${_korisnik!.ime} ${_korisnik!.prezime}"))

              ],))

            ],
          ),
        );
      
    }
  }
}

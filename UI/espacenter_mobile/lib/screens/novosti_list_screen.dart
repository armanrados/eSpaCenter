import 'package:espacenter_mobile/models/novosti.dart';
import 'package:espacenter_mobile/providers/novosti_provider.dart';
import 'package:espacenter_mobile/screens/galerija_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';
import 'novosti_detalji_screen.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({Key? key}) : super(key: key);
  static const String routeName = "/novosti";

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {
  NovostiProvider? _novostiProvider;
  List<Novosti> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _novostiProvider!.get({'isDeleted': false});
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: buildNovosti(),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, GalerijaListScreen.routeName);
        },
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
        child: const Icon(Icons.photo_library_rounded),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Dobrodošli ${Authorization.username}!",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }

  List<Widget> buildNovosti() {
    if (data.isEmpty) {
      return [
        Center(
          child: Text("Nema podataka za prikaz"),
        )
      ];
    }

    List<Widget> list = data
        .map((e) => Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,
                        "${NovostiDetaljiScreen.routeName}/${e.novostiID}");
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: imageFromBase64String(e.slika!),
                            
                            
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                                e.naslov!,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              Container(
                                height: 20,
                              ),
                              Text(
                                e.sadrzaj!,
                                style: TextStyle(
                                    fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ]),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}

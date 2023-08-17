import 'package:espacenter_mobile/models/galerija.dart';
import 'package:espacenter_mobile/providers/galerija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class GalerijaListScreen extends StatefulWidget {
  const GalerijaListScreen({Key? key}) : super(key: key);
  static const String routeName = "/galerija";
  @override
  State<GalerijaListScreen> createState() => _GalerijaListScreenState();
}

class _GalerijaListScreenState extends State<GalerijaListScreen> {
  GalerijaProvider? _galerijaProvider;
  List<Galerija> data = [];

  @override
  void initState() {
  
    super.initState();
    _galerijaProvider = context.read<GalerijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _galerijaProvider!
        .get({'includeKorisnik': true, 'isDeleted': false});
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galerija"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
                  child : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildGallery(),
                      ),
                    ),
                  )
      ),
          ),
        );
      
    
  }

  List<Widget> _buildGallery() {
    var list = data
        .map((e) => Column(children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: imageFromBase64String(e.slikaByte!),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.opis!,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            ]),
                      )
                    ]),
              )
            ]))
        .cast<Widget>()
        .toList();

    return list;
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/galerija.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/galerija_provider.dart';
import 'package:espacenter_admin/screens/galerija_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../utils/util.dart';

class GalerijaScreen extends StatefulWidget {
  const GalerijaScreen({Key? key}) : super(key: key);

  @override
  State<GalerijaScreen> createState() => _GalerijaScreenState();
}

class _GalerijaScreenState extends State<GalerijaScreen> {
  late GalerijaProvider _galerijaProvider;
  SearchResult<Galerija>? result;
  TextEditingController _opisController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _galerijaProvider = context.read<GalerijaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Galerija",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Opis"),
              controller: _opisController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton.icon(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _galerijaProvider.get(filter: {
                  'opis': _opisController.text,
                  'includeKorisnik' : true
                 
                });

                setState(() {
                  result = data;
                });

                
              },
               icon: Icon(Icons.search),  //icon data for elevated button
                 label: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GalerijaDetaljiScreen(
                      galerija: null,
                    ),
                  ),
                );
                
              },
              icon: Icon(Icons.add),
              label: Text("Nova slika")
          )
              
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
          width: double.infinity,
          child :DataTable(
              columns: [   const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Slika',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                 const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Opis',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
             
              ],
              dataRowHeight: 150,
              rows: result?.result
                      .map((Galerija e) => DataRow(
                              onLongPress: ()  => {
                                   
                                      {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GalerijaDetaljiScreen(
                                              galerija: e,
                                            ),
                                          ),
                                        )
                                      }
                                  },
                              cells: [
                                
                                

                                DataCell(e.slikaByte != ""
                                    ? Container(
                                        width: 200,
                                        height: 145,
                                        child: imageFromBase64String(e.slikaByte!),
                                      )
                                    : Text("")),
                                DataCell(Text(e.opis ?? "")),
                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

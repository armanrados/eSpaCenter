// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/novost.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/screens/novosti_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../utils/util.dart';

class NovostiScreen extends StatefulWidget {
  const NovostiScreen({Key? key}) : super(key: key);

  @override
  State<NovostiScreen> createState() => _NovostiScreenState();
}

class _NovostiScreenState extends State<NovostiScreen> {
  late NovostProvider _novostProvider;
  SearchResult<Novost>? result;
  TextEditingController _naslovController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _novostProvider = context.read<NovostProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Novosti",
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
              controller: _naslovController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _novostProvider.get(filter: {
                  'naslov': _naslovController.text,
                 
                });

                setState(() {
                  result = data;
                });

                
              },
              child: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NovostiDetaljiScreen(
                      novost: null,
                    ),
                  ),
                );
                
              },
              icon: Icon(Icons.add),
              label: Text("Nova novost")
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
                      'Naslov',
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                 const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sadržaj',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
             
              ],
              rows: result?.result
                      .map((Novost e) => DataRow(
                              onSelectChanged: (selected) => {
                                    if (selected == true)
                                      {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NovostiDetaljiScreen(
                                              novost: e,
                                            ),
                                          ),
                                        )
                                      }
                                  },
                              cells: [
                                
                                

                                DataCell(e.slika!= ""
                                    ? Container(
                                        width: 100,
                                        height: 1500,
                                        child: imageFromBase64String(e.slika!),
                                      )
                                    : Text("")),
                                DataCell(Text(e.naslov ?? "")),
                                DataCell(Text(e.sadrzaj ?? "")),

                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

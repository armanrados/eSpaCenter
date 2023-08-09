// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:espacenter_admin/models/novosti.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/screens/novosti_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class NovostScreen extends StatefulWidget {
  const NovostScreen({Key? key}) : super(key: key);

  @override
  State<NovostScreen> createState() => _NovostScreenState();
}

class _NovostScreenState extends State<NovostScreen> {
  late NovostProvider _novostProvider;
  SearchResult<Novosti>? result;
  TextEditingController _naslovController = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _novostProvider = context.read<NovostProvider>();
    _loadData();
  }

 Future<void> _loadData() async {
    var data = await _novostProvider.get(filter: {
      'naslov': _naslovController.text,
      'isDeleted': false,
    });

    setState(() {
      result = data;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Naslov"),
              controller: _naslovController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
           ElevatedButton.icon(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _novostProvider.get(filter: {
                  'naslov': _naslovController.text,
                  'isDeleted' : false
                 
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
                    builder: (context) => NovostiDetaljiScreen(
                      novosti: null,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Nova novost"))
        ],
      ),
    );
  }

 Widget _buildDataListView() {
  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: DataTable(
          columns: [
            const DataColumn(
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
                  style: TextStyle(fontStyle: FontStyle.italic),
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
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Izbriši',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          dataRowHeight: 150,
        rows: result?.result
                      .map((Novosti e) => DataRow(
                               onLongPress: () => {
                                
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NovostiDetaljiScreen(
                                          novosti: e,
                                        ),
                                      ),
                                    )
                                  
                              },
                              cells: [
                                
                                 DataCell((e.slika != ""
                      ? Container(
                          width: 200,
                          height: 145,
                          child: imageFromBase64String(e.slika!),
                        )
                      : Text(""))),
                                 DataCell(Text(e.naslov ?? "")),

                                 DataCell(Text(e.sadrzaj ?? "")),
                              DataCell(
                      IconButton(
                        onPressed: () async {
                          // Set the isDeleted property to true
                          e.isDeleted = true;

                          // Update the 'e' object in your provider to mark it as deleted
                          await _novostProvider.update(e.novostiID!, e);
                         _loadData();

                          setState(() {
                            // No need to refresh the state here, row will be hidden
                          });
                        },
                        icon: Icon(Icons.delete),
                       
                      ),
                    ),
                  ],
                ),
              )
              .toList() ??
              [],),
      ),
    ));
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
}

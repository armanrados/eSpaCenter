// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/termin_provider.dart';
import 'package:espacenter_admin/screens/termin_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/termin.dart';
import '../utils/util.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}) : super(key: key);

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  late TerminProvider _terminProvider;
  SearchResult<Termin>? result;
  TextEditingController _korisnikIDController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _terminProvider = context.read<TerminProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Termini",
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
              decoration: InputDecoration(labelText: "ID"),
              controller: _korisnikIDController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _terminProvider.get(filter: {
                  'korisnikID': _korisnikIDController.text,
                 
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
                    builder: (context) => TerminDetaljiScreen(
                      termin: null,
                    ),
                  ),
                );
                
              },
              icon: Icon(Icons.add),
              label: Text("Novi Termin")
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
              columns: [
             
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Zaposlenik',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Datum termina',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Vrijeme termina',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                
              ],
              rows: result?.result
                      .map((Termin e) => DataRow(
                              onSelectChanged: (selected) => {
                                    if (selected == true)
                                      {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TerminDetaljiScreen(
                                              termin: e,
                                            ),
                                          ),
                                        )
                                      }
                                  },
                              cells: [
                                
                                DataCell( Text(e.korisnik?.ime ?? "d")),
                                DataCell(Text(e.datumTermina.toString())),
                                DataCell(Text(e.vrijemeTermina ?? ""))
                               

                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

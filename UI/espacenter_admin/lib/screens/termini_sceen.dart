// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/termin_provider.dart';
import 'package:espacenter_admin/screens/termin_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/material.dart';
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
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _terminProvider.get(filter: {
      'korisnikID': _korisnikIDController.text,
      'isDeleted': false,
      'includeKorisnik': true
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
              decoration: InputDecoration(labelText: "ID Zaposlenika"),
              controller: _korisnikIDController,
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton.icon(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _terminProvider.get(filter: {
                  'korisnikID': _korisnikIDController.text,
                  'isDeleted': false,
                  'includeKorisnik': true
                });

                setState(() {
                  result = data;
                });
              },
              icon: Icon(Icons.search), //icon data for elevated button
              label: Text("Pretraga")),
          SizedBox(width: 8),
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
            label: Text("Novi Termin"),
          ),
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
                    'ID',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
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
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Izbriši',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: result?.result
                    .map(
                      (Termin e) => DataRow(
                         onLongPress: () => {
                                
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TerminDetaljiScreen(
                                          termin: e,
                                        ),
                                      ),
                                    )
                                  
                              },
                        cells: [
                          DataCell(Text(e.korisnikID.toString())),
                          DataCell(Text(e.korisnik?.ime ?? "")),
                          DataCell(Text(formatDate(e.datumTermina ?? DateTime.now()))),
                          DataCell(Text(e.vrijemeTermina ?? "")),
                          DataCell(
                            IconButton(
                              onPressed: () async {
                                // Set the isDeleted property to true
                                e.isDeleted = true;

                                // Update the 'e' object in your provider to mark it as deleted
                                await _terminProvider.update(
                                    e.terminID!, e);
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
                [],
          ),
        ),
      ),
    );
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
}

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
import 'package:intl/intl.dart';
import '../models/termin.dart';
import '../utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}) : super(key: key);

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  late TerminProvider _terminProvider;
  SearchResult<Termin>? result;
  TextEditingController _korisnikIDController = new TextEditingController();
  Map<int, bool> _rowVisibilityMap = {};
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _terminProvider = context.read<TerminProvider>();
    _fetchData();
  }
Future<void> _fetchData() async {
  if (_korisnikIDController.text.isEmpty) {
    // No search filter, fetch all data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await _terminProvider.get(
      filter: {
        'includeKorisnik': true,
      },
    );

    setState(() {
      result = data;
      _loadVisibilityState(prefs); // Load visibility state from SharedPreferences
    });
  } else {
    // Apply search filter
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await _terminProvider.get(
      filter: {
        'korisnikID': _korisnikIDController.text,
        'includeKorisnik': true,
      },
    );

    setState(() {
      result = data;
      _loadVisibilityState(prefs); // Load visibility state from SharedPreferences
    });
  }
}
 void _loadVisibilityState(SharedPreferences prefs) {
    for (var termin in result!.result) {
      bool isVisible = prefs.getBool('termin_${termin.terminID}') ?? true;
      termin.isVisible = isVisible;
      _rowVisibilityMap[termin.terminID!] = isVisible;
    }
  }
 void _toggleRowVisibility(int index) async {
    if (index >= 0 && index < (result?.result.length ?? 0)) {
      Termin termin = result!.result[index];
      setState(() {
        termin.isVisible = !termin.isVisible;
        _rowVisibilityMap[termin.terminID!] = termin.isVisible; // Update the visibility state in the map
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('termin_${termin.terminID}', termin.isVisible);
    }
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
              await _fetchData();

            },
            icon: Icon(Icons.search),
            label: Text("Pretraga"),
          ),
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
          child :DataTable(
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
              rows: result?.result != null
                ? [
                    for (int i = 0; i < result!.result.length; i++)
                      if (!_rowVisibilityMap.containsKey(result!.result[i].terminID) || _rowVisibilityMap[result!.result[i].terminID]!)
                        DataRow(
                          onLongPress: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TerminDetaljiScreen(
                                termin: result!.result[i],
                              ),
                            ),
                          ),
                          cells: [
                            DataCell(Text(result!.result[i].korisnikID.toString())),
                            DataCell(Text(result!.result[i].korisnik?.ime ?? "")),

                            DataCell(Text(result!.result[i].datumTermina != null ? DateFormat('yyyy-MM-dd').format(result!.result[i].datumTermina!) : 'N/A')),
                            DataCell(Text(result!.result[i].vrijemeTermina ?? "")),
                            DataCell(
                              IconButton(
                                onPressed: () => _toggleRowVisibility(i),
                                icon: Icon(Icons.delete),
                                
                              ),
                            ),
                          ],
                        ),
                  ]
                : [],
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


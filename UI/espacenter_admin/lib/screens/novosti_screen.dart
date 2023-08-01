// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/novosti.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/screens/novosti_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/proizvod.dart';
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
  Map<int, bool> _rowVisibilityMap = {};

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _novostProvider = context.read<NovostProvider>();
    _fetchData();
  }

Future<void> _fetchData() async {
    if (_naslovController.text.isEmpty) {
      // No search filter, fetch all data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await _novostProvider.get(
        filter: {'includeKorisnik': true},
      );

      setState(() {
        result = data;
        _loadVisibilityState(
            prefs); // Load visibility state from SharedPreferences
      });
    } else {
      // Apply search filter
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await _novostProvider.get(
        filter: {'naslov': _naslovController.text, 'includeKorisnik': true},
      );

      setState(() {
        result = data;
        _loadVisibilityState(
            prefs); // Load visibility state from SharedPreferences
      });
    }
  }


  void _loadVisibilityState(SharedPreferences prefs) {
    for (var novosti in result!.result) {
      bool isVisible = prefs.getBool('novosti_${novosti.novostiID}') ?? true;
      novosti.isVisible = isVisible;
      _rowVisibilityMap[novosti.novostiID!] = isVisible;
    }
  }

   void _toggleRowVisibility(int index) async {
    if (index >= 0 && index < (result?.result.length ?? 0)) {
      Novosti novosti = result!.result[index];
      setState(() {
        novosti.isVisible = !novosti.isVisible;
        _rowVisibilityMap[novosti.novostiID!] =
            novosti.isVisible; // Update the visibility state in the map
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('novosti_${novosti.novostiID}', novosti.isVisible);
    }
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
              await _fetchData();
            },
            icon: Icon(Icons.search),
            label: Text("Pretraga"),
          ),
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
  List<Novosti> visibleNovosti = result?.result != null
        ? result!.result.where((novosti) {
            return _rowVisibilityMap.containsKey(novosti.novostiID)
                ? _rowVisibilityMap[novosti.novostiID]!
                : true;
          }).toList()
        : [];

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
         rows: visibleNovosti.map((novosti) {
            int index = result!.result.indexOf(novosti);
            return DataRow(
              onLongPress: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NovostiDetaljiScreen(
                    novosti: result!.result[index],
                  ),
                ),
              ),
              cells: [
                DataCell((novosti.slika != ""
                    ? Container(
                        width: 200,
                        height: 145,
                        child: imageFromBase64String(novosti.slika!),
                      )
                    : Text(""))),
                DataCell(Text(novosti.naslov ?? "")),
                DataCell(Text(novosti.sadrzaj ?? "")),

                DataCell(
                  IconButton(
                    onPressed: () => _toggleRowVisibility(index),
                    icon: Icon(Icons.delete),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
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

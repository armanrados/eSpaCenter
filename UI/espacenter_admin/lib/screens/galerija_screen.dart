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
import 'package:shared_preferences/shared_preferences.dart';
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
  Map<int, bool> _rowVisibilityMap = {};

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _galerijaProvider = context.read<GalerijaProvider>();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_opisController.text.isEmpty) {
      // No search filter, fetch all data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await _galerijaProvider.get(
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
      var data = await _galerijaProvider.get(
        filter: {'opis': _opisController.text, 'includeKorisnik': true},
      );

      setState(() {
        result = data;
        _loadVisibilityState(
            prefs); // Load visibility state from SharedPreferences
      });
    }
  }

  void _loadVisibilityState(SharedPreferences prefs) {
    for (var galerija in result!.result) {
      bool isVisible = prefs.getBool('galerija_${galerija.galerijaID}') ?? true;
      galerija.isVisible = isVisible;
      _rowVisibilityMap[galerija.galerijaID!] = isVisible;
    }
  }

  void _toggleRowVisibility(int index) async {
    if (index >= 0 && index < (result?.result.length ?? 0)) {
      Galerija galerija = result!.result[index];
      setState(() {
        galerija.isVisible = !galerija.isVisible;
        _rowVisibilityMap[galerija.galerijaID!] =
            galerija.isVisible; // Update the visibility state in the map
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('galerija_${galerija.galerijaID}', galerija.isVisible);
    }
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
                    builder: (context) => GalerijaDetaljiScreen(
                      galerija: null,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Nova slika"))
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    List<Galerija> visibleGalerija = result?.result != null
        ? result!.result.where((galerija) {
            return _rowVisibilityMap.containsKey(galerija.galerijaID)
                ? _rowVisibilityMap[galerija.galerijaID]!
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
                  'Opis',
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
          rows: visibleGalerija.map((galerija) {
            int index = result!.result.indexOf(galerija);
            return DataRow(
              onLongPress: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GalerijaDetaljiScreen(
                    galerija: result!.result[index],
                  ),
                ),
              ),
              cells: [
                DataCell((galerija.slikaByte != ""
                    ? Container(
                        width: 200,
                        height: 145,
                        child: imageFromBase64String(galerija.slikaByte!),
                      )
                    : Text(""))),
                DataCell(Text(galerija.opis ?? "")),
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
      title: "Galerija",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }
}

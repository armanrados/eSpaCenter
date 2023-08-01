// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/screens/proizvod_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProizvodScreen extends StatefulWidget {
  const ProizvodScreen({Key? key}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? result;
  TextEditingController _nazivController = new TextEditingController();
  Map<int, bool> _rowVisibilityMap = {};

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();
    _fetchData();

  }
 Future<void> _fetchData() async {
    if (_nazivController.text.isEmpty) {
      // No search filter, fetch all data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await _proizvodProvider.get(
        filter: {
          'includeVrstaProizvoda': true,
        },
      );

      setState(() {
        result = data;
        _loadVisibilityState(prefs); // Load visibility state from SharedPreferences
      });
    } else {
      // Apply search filter
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await _proizvodProvider.get(
        filter: {
          'naziv': _nazivController.text,
          'includeVrstaProizvoda': true,
        },
      );

      setState(() {
        result = data;
        _loadVisibilityState(prefs); // Load visibility state from SharedPreferences
      });
    }
  }
 void _loadVisibilityState(SharedPreferences prefs) {
    for (var proizvod in result!.result) {
      bool isVisible = prefs.getBool('proizvod_${proizvod.proizvodID}') ?? true;
      proizvod.isVisible = isVisible;
      _rowVisibilityMap[proizvod.proizvodID!] = isVisible;
    }
  }
  void _toggleRowVisibility(int index) async {
    if (index >= 0 && index < (result?.result.length ?? 0)) {
      Proizvod proizvod = result!.result[index];
      setState(() {
        proizvod.isVisible = !proizvod.isVisible;
        _rowVisibilityMap[proizvod.proizvodID!] = proizvod.isVisible; // Update the visibility state in the map
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('proizvod_${proizvod.proizvodID}', proizvod.isVisible);
    }
  }



  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Naziv"),
              controller: _nazivController,
            ),
          ),
          SizedBox(width: 8,),
        
          ElevatedButton.icon(
            onPressed: () async {
              await _fetchData();

            },
            icon: Icon(Icons.search),
            label: Text("Pretraga"),
          ),
          SizedBox(width: 8,),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProizvodDetaljiScreen(
                      proizvod: null,
                    ),
                  ),
                );
                
              },
              icon: Icon(Icons.add),
              label: Text("Novi proizvod")
          )
              
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    List<Proizvod> visibleProizvodi = result?.result != null
        ? result!.result.where((proizvod) {
            return _rowVisibilityMap.containsKey(proizvod.proizvodID)
                ? _rowVisibilityMap[proizvod.proizvodID]!
                : true;
          }).toList()
        : [];
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
          width: double.infinity,
          child :DataTable(
              columns: [
             
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Šifra',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Naziv',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cijena',
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
                      'Slika',
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
              rows: visibleProizvodi.map((proizvod) {
              int index = result!.result.indexOf(proizvod);
              return DataRow(
                onLongPress: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProizvodDetaljiScreen(
                      proizvod: result!.result[index],
                    ),
                  ),
                ),
                cells: [
                  DataCell(Text(proizvod.sifra ?? "")),
                  DataCell(Text(proizvod.naziv ?? "")),
                  DataCell(Text(proizvod.cijena.toString())),
                  DataCell(Text(proizvod.opis ?? "")),
                  DataCell((proizvod.slika != ""
                      ? Container(
                          width: 60,
                          height: 145,
                          child: imageFromBase64String(proizvod.slika!),
                        )
                      : Text(""))),
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
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Proizvodi",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }
}

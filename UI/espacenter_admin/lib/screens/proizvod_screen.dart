// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/screens/proizvod_detalji_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../utils/util.dart';

class ProizvodScreen extends StatefulWidget {
  const ProizvodScreen({Key? key}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? result;
  TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _proizvodProvider.get(filter: {
      'naziv': _nazivController.text,
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
              decoration: InputDecoration(labelText: "Naziv"),
              controller: _nazivController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          ElevatedButton.icon(
              onPressed: () async {

                var data = await _proizvodProvider.get(filter: {
                  'naziv': _nazivController.text,
                  'isDeleted': false,
                });

                setState(() {
                  result = data;
                });
              },
              icon: Icon(Icons.search), //icon data for elevated button
              label: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
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
              label: Text("Novi proizvod"))
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
            rows: result?.result
                    .map(
                      (Proizvod e) => DataRow(
                         onLongPress: () => {
                                
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProizvodDetaljiScreen(
                                          proizvod: e,
                                        ),
                                      ),
                                    )
                                  
                              },
                        cells: [
                          DataCell(Text(e.naziv ?? "")),
                          DataCell(Text(formatNumber(e.cijena))),
                          DataCell(Text(e.opis ?? "")),
                          DataCell((e.slika != ""
                              ? Container(
                                  width: 60,
                                  height: 145,
                                  child: imageFromBase64String(e.slika!),
                                )
                              : Text(""))),
                          
                          DataCell(
                            IconButton(
                              onPressed: () async {
                                e.isDeleted = true;

                                await _proizvodProvider.update(
                                    e.proizvodID!, e);
                                _loadData();

                                setState(() {
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
      title: "Proizvodi",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }
}

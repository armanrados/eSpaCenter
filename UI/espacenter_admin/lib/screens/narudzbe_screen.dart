// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:espacenter_admin/models/narudzba.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/narudzba_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/narudzba_detalji_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/util.dart';

class NarudzbeScreen extends StatefulWidget {
  const NarudzbeScreen({Key? key}) : super(key: key);

  @override
  State<NarudzbeScreen> createState() => _NarudzbeScreenState();
}

class _NarudzbeScreenState extends State<NarudzbeScreen> {
  late NarudzbaProvider _narudzbaProvider;
  SearchResult<Narudzba>? result;
  TextEditingController _brojNarudzbeController = new TextEditingController();
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _narudzbaProvider.get(filter: {
      'brojNarudzbe': _brojNarudzbeController.text,
      'includeKorisnik': true,
      'includeNarudzbaProizvodi': true,
      'includeUplata': true,
      'isCanceled': false,
      'isShipped' : false
    });

    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Narudžbe",
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
              decoration: InputDecoration(labelText: "Broj narudžbe"),
              controller: _brojNarudzbeController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          ElevatedButton.icon(
              onPressed: () async {

                var data = await _narudzbaProvider.get(filter: {
                  'brojNarudzbe': _brojNarudzbeController.text,
                  'includeKorisnik': true,
                  'includeNarudzbaProizvodi': true,
                  'includeUplata': true,
                  'isCanceled': false,
                  'isShipped' : false
                });

                setState(() {
                  result = data;
                });
              },
              icon: Icon(Icons.search), //icon data for elevated button
              label: Text("Pretraga")),
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
                    'Broj narudžbe',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Datum narudžbe',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Ukupna cijena',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Pošalji narudžbu',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
               const DataColumn(
                label: Expanded(
                  child: Text(
                    'Detalji narudžbe',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: result?.result
                    .map((Narudzba e) => DataRow(cells: [
                          DataCell(Text(e.brojNarudzbe.toString())),
                          DataCell(Text(
                              formatDate(e.datumNarudzbe ?? DateTime.now()))),
                          DataCell(Text(e.ukupnaCijena.toString())),
                          DataCell(IconButton(
                            onPressed: () async
                            {
                              Map updateNarudzba =
                              {
                                  'brojNarudzbe': _brojNarudzbeController.text,
                                  'includeKorisnik': true,
                                  'includeNarudzbaProizvodi': true,
                                  'includeUplata': true,
                                  'isCanceled': false,
                                  'isShipped' : true
                              };
                                await _narudzbaProvider.update(e.narudzbaID! ,updateNarudzba );
                                _loadData();
                            },
                            
                            icon: Icon(Icons.local_shipping)
                          )),
                            DataCell(IconButton(
                            onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NarudzbaDetailScreen(narudzba: e),
                            ),
                          );
                        },
                        icon: Icon(Icons.list_alt),
                          ))
                        ]))
                    .toList() ??
                []),
      ),
    ));
  }
}

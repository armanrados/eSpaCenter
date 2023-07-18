// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/narudzba.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/narudzba_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/termin.dart';
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
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _narudzbaProvider = context.read<NarudzbaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Narudzbe",
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
              decoration: InputDecoration(labelText: "Broj narudzbe"),
              controller: _brojNarudzbeController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _narudzbaProvider.get(filter: {
                  'brojNarudzbe': _brojNarudzbeController.text,
                 
                });

                setState(() {
                  result = data;
                });

                
              },
              child: Text("Pretraga")),
      
              
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
                      'Broj narudzbe',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Datum naruzbe',
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
                
              ],
                rows: result?.result
                      .map((Narudzba e) => DataRow(
                              
                              cells: [
                                
                                DataCell( Text(e.brojNarudzbe.toString())),
                                DataCell(Text(e.datumNarudzbe.toString())),
                                DataCell(Text(formatNumber(e.ukupnaCijena)))
                               

                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

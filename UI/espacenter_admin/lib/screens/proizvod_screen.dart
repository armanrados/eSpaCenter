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

class ProizvodScreen extends StatefulWidget {
  const ProizvodScreen({Key? key}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? result;
  TextEditingController _nazivController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();
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
                // Navigator.of(context).pop();

                var data = await _proizvodProvider.get(filter: {
                  'naziv': _nazivController.text,
                  'includeVrstaProizvoda' : true
                 
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
                )
              ],
              rows: result?.result
                      .map((Proizvod e) => DataRow(
                              onLongPress: ()  => {
                                    
                                      {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProizvodDetaljiScreen(
                                              proizvod: e,
                                            ),
                                          ),
                                        )
                                      }
                                  },
                              cells: [
                                
                                DataCell( Text(e.sifra ?? "")),
                                DataCell(Text(e.naziv ?? "")),
                                DataCell(Text(formatNumber(e.cijena))),
                                DataCell(Text(e.opis ?? "")),

                                DataCell(e.slika != ""
                                    ? Container(
                                        width: 40,
                                        height: 40,
                                        child: imageFromBase64String(e.slika!),
                                      )
                                    : Text(""))
                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

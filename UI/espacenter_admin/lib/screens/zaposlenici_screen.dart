// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/korisnik.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/korisnik_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/zaposlenici_detalji_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ZaposleniciScreen extends StatefulWidget {
  const ZaposleniciScreen({Key? key}) : super(key: key);

  @override
  State<ZaposleniciScreen> createState() => _ZaposleniciScreenState();
}

class _ZaposleniciScreenState extends State<ZaposleniciScreen> {
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? result;
  TextEditingController _imeController = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _korisnikProvider.get(filter: {
      'korisnickoIme': _imeController.text,
      'includeUloge': true,
      'isDeleted': false
    });

    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Zaposlenici",
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
              decoration: InputDecoration(labelText: "Ime"),
              controller: _imeController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton.icon(
              onPressed: () async {

                var data = await _korisnikProvider.get(filter: {
                  'korisnickoIme': _imeController.text,
                  'includeUloge' : true,
                  'isDeleted' : false
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
                    builder: (context) => ZaposleniciDetaljiScreen(
                      korisnik: null,
                    ),
                  ),
                );
                
              },
              icon: Icon(Icons.add),
              label: Text("Novi zaposlenik")
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
              columns: [   const DataColumn(
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
                    'Izbriši',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              ],
              rows: result?.result
                      .map((Korisnik e) => DataRow(
                              
                              cells: [
                                DataCell(Text(e.korisnickoIme ?? "")),
                                 DataCell(
                            IconButton(
                              onPressed: () async {
                                e.isDeleted = true;

                                await _korisnikProvider.update(
                                    e.korisnikID!, e);
                                await _loadData();
                              
                                setState(() {
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/rezervacija_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/rezervacija.dart';
import '../utils/util.dart';

class RezervacijeScreen extends StatefulWidget {
  const RezervacijeScreen({Key? key}) : super(key: key);

  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  SearchResult<Rezervacija>? result;
  TextEditingController _korisnikIDController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Rezervacije",
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
              decoration: InputDecoration(labelText: "ID"),
              controller: _korisnikIDController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).pop();

                var data = await _rezervacijaProvider.get(filter: {
                  'korisnikID': _korisnikIDController.text,
                 
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
                      'Klijent',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(
                      'Datum rezervacije',
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
                
              ],
              rows: result?.result
                      .map((Rezervacija e) => DataRow(
                            
                              cells: [
                                
                                DataCell( Text(e.termin?.korisnik?.ime ?? "")),
                                DataCell(Text(e.datumRezervacije.toString())),
                                DataCell(Text(e.termin?.vrijemeTermina ?? ""))
                               

                              ]))
                      .toList() ??
                  []),
        
      ),
    ));
  }
}

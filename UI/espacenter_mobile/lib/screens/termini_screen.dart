import 'package:espacenter_mobile/screens/rezervacija_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/termin.dart';
import '../models/usluga.dart';
import '../providers/rezervacija_provider.dart';
import '../providers/termin_provider.dart';
import '../providers/usluga_provider.dart';
import '../utils/util.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}): super(key: key);
  

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
 TerminProvider? _terminProvider;
  UslugaProvider? _uslugaProvider;
  RezervacijaProvider? _rezervacijaProvider;
  List<Termin> data = [];
  List<Usluga> usluga = [];
  Usluga? _selectedItem;
  TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uslugaProvider = context.read<UslugaProvider>();
    _terminProvider = context.read<TerminProvider>();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpUsluga = await _uslugaProvider?.get();
    var tmpData = await _terminProvider?.get(
        {'isBooked': false, 'includeKorisnik': true, 'isDeleted': false});
    setState(() {
      data = tmpData!;
      usluga = tmpUsluga!;
      _selectedItem = usluga[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Termini"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RezervacijaScreen.routeName);
        },
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
        child: const Icon(Icons.calendar_month),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Izaberi datum"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));
                              var tmpData = await _terminProvider!.get({
                            'isBooked': false,
                            'includeKorisnik': true,
                            'isDeleted' : false,
                            'datum': pickedDate
                          });
                          if (pickedDate != null) {
                            setState(() {
                              date = pickedDate;
                              dateController.text = formatDate(pickedDate);
                              data = tmpData;
                            });
                          }
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildTermini(),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              "Rezervacije",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            )
          ],
        ));
  }

  List<Widget> _buildTermini() {
    if (data.length == 0) {
      return [
        Center(
          child: Text("Nema podataka za prikaz"),
        )
      ];
    }

    List<Widget> list = data
        .map((e) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                      "Termin kod ${e.korisnik!.ime} ${e.korisnik!.prezime}"),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                        "${formatDate(e.datumTermina!)}"),
                                  )
                                ],
                              ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(e.vrijemeTermina!),
                                DropdownButton<Usluga>(
                                    underline: SizedBox(),
                                    value: _selectedItem,
                                    items: usluga
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.naziv!),
                                              value: e,
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedItem = val as Usluga;
                                      });
                                    }),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 23, 121, 251)),
                                  onPressed: () async {
                                    Map item = {
                                      "korisnikID":
                                          Authorization.korisnik!.korisnikID,
                                      "terminID": e.terminID,
                                      "uslugaID": _selectedItem!.uslugaID,
                                      "isCanceled": false,
                                      "isArchived": false
                                    };

                                    await _rezervacijaProvider!.insert(item);
                                    loadData();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Rezervacija termina uspješna")));
                                  },
                                  child: Text("Rezervisi"),
                                )
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ],
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}
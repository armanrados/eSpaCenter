// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/rezervacija_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/material.dart';
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
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _rezervacijaProvider.get(filter: {
      'korisnikID': _korisnikIDController.text,
      'includeTermin': true,
      'includeKorisnik': true,
      'includeUsluga': true,
      'isCompleted': false,
      'isCanceled': false
    });

    setState(() {
      result = data;
    });
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
          ElevatedButton.icon(
              onPressed: () async {

                var data = await _rezervacijaProvider.get(filter: {
                  'korisnikID': _korisnikIDController.text,
                  'includeTermin': true,
                  'includeKorisnik': true,
                  'includeUsluga': true,
                  'isCompleted': false,
                  'isCanceled': false
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
   List<Rezervacija> filteredReservations = result?.result
      .where((reservation) =>
          !reservation.isCanceled! && !reservation.termin!.isDeleted!)
      .toList() ?? [];

  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
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
          rows: filteredReservations
              .map(
                (Rezervacija e) => DataRow(cells: [
                  DataCell(Text(e.korisnikID.toString())),
                  DataCell(Text(e.terminRezervisao ?? "")),
                  DataCell(Text(formatDate(e.datumRezervacije ?? DateTime.now()))),
                  DataCell(Text(e.termin?.vrijemeTermina ?? ""))
                ]),
              )
              .toList(),
        ),
      ),
    ),
  );
}

}

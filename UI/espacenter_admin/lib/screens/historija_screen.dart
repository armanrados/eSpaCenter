// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:espacenter_admin/models/narudzba.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/narudzba_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:espacenter_admin/screens/narudzba_detalji_screen.dart';

import '../utils/util.dart';
import 'package:pdf/widgets.dart' as pw;

class HistorijaScreen extends StatefulWidget {
  const HistorijaScreen({Key? key}) : super(key: key);

  @override
  State<HistorijaScreen> createState() => _HistorijaScreenState();
}

class _HistorijaScreenState extends State<HistorijaScreen> {
  late NarudzbaProvider _narudzbaProvider;
  SearchResult<Narudzba>? result;
  TextEditingController _brojNarudzbeController = new TextEditingController();
  int pdfCounter = 1;
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
      'isShipped': true,
      
    });

    setState(() {
      result = data;
    });
  }
   Future<Uint8List> generatePdfContent(List<Narudzba> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return  pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Izvjestaj',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),pw.Table.fromTextArray(
            headers: const ['ID', 'Broj narudzbe', 'Datum narudzbe', 'Ukupna cijena'],
            data: <List<String>>[
              for (var narudzba in data)
                [narudzba.narudzbaID.toString(), narudzba.brojNarudzbe.toString(), formatDate(narudzba.datumNarudzbe ?? DateTime.now()), formatNumber(narudzba.ukupnaCijena)],
            ],
          )]);
        },
      ),
    );

    return pdf.save();
  }

  Future<String?> saveAndLaunchPdf(Uint8List pdfContent) async {
    try {
    final pdfPath = 'izvjestaj_$pdfCounter.pdf';
    final pdfFile = File(pdfPath);

    await pdfFile.writeAsBytes(pdfContent);

    pdfCounter++; 

    return pdfFile.path;
  } catch (e) {
    print('Error saving PDF: $e');
    return null;
  }
}

  

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Historija",
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
                  'isShipped': true,
                  
                });

                setState(() {
                  result = data;
                });
              },
              icon: Icon(Icons.search), 
              label: Text("Pretraga")),
          SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              onPressed: () async {
              if (result != null) {
          final pdfContent = await generatePdfContent(result!.result);
          final pdfUrl = await saveAndLaunchPdf(pdfContent);
          
          if (pdfUrl != null) {
            await launchUrlString(pdfUrl);
          } else {
          }
        }
      },
      icon: Icon(Icons.print),
      label: Text("Printaj"),
    ),
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
                    'ID',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
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
                    'Detalji narudžbe',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: result?.result
                    .map((Narudzba e) => DataRow(cells: [
                          DataCell(Text(e.narudzbaID.toString())),
                          DataCell(Text(e.brojNarudzbe.toString())),
                          DataCell(Text(
                              formatDate(e.datumNarudzbe ?? DateTime.now()))),
                          DataCell(Text(e.ukupnaCijena.toString())),
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

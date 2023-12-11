import 'package:flutter/material.dart';
import 'package:espacenter_admin/models/narudzba.dart';
import 'package:espacenter_admin/utils/util.dart';

class NarudzbaDetailScreen extends StatelessWidget {
  final Narudzba narudzba;

  const NarudzbaDetailScreen({Key? key, required this.narudzba}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji narudžbe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Broj narudžbe', narudzba.brojNarudzbe!),
            _buildDetailItem('Datum narudžbe', formatDate(narudzba.datumNarudzbe!)),
            _buildDetailItem('Ukupna cijena', '${narudzba.ukupnaCijena} KM'),
            _buildDetailItem('Naručeni proizvodi', narudzba.narudzbaProizvodi!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}


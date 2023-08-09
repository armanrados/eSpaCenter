import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/korisnik.dart';
import '../models/recenzija.dart';
import '../providers/korisnik_provider.dart';
import '../providers/recenzija_provider.dart';

class RecenzijaDetaljiScreen extends StatefulWidget {
  static const String routeName = "/recenzija_detalji";
  String id;
  RecenzijaDetaljiScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<RecenzijaDetaljiScreen> createState() => _RecenzijaDetaljiScreenState();
}

class _RecenzijaDetaljiScreenState extends State<RecenzijaDetaljiScreen> {
  RecenzijaProvider? _recenzijaProvider;
  KorisnikProvider? _korisnikProvider;
  Korisnik? korisnik;
  Recenzija? recenzija;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    loadData();
  }

  Future loadData() async {
    var tmp = await _recenzijaProvider!.getById(int.parse(this.widget.id));
    var tmpKorisnik = await _korisnikProvider!.getById(tmp.korisnikID!);
    setState(() {
      recenzija = tmp;
      korisnik = tmpKorisnik;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalji recenzije"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [RecenzijaDetalji()]),
        ),
      ),
    );
  }

  Widget RecenzijaDetalji() {
    if (recenzija == null) {
      return Center(
        child: Text("Ucitavanje"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${korisnik!.ime} ${korisnik!.prezime}",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    RatingBar(
                        ignoreGestures: true,
                        itemSize: 40,
                        maxRating: 5,
                        minRating: 1,
                        initialRating: recenzija!.ocjena!.toDouble(),
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Icon(Icons.star, color: Colors.amber),
                            empty: Icon(Icons.star, color: Colors.grey)),
                        onRatingUpdate: (rate) {}),
                    SizedBox(height: 15),
                    Text(
                      "${recenzija!.sadrzajRecenzije}",
                      style: TextStyle(fontSize: 16),
                    )
                  ]),
            )),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../providers/recenzija_provider.dart';
import '../utils/util.dart';

class RecenzijaDodajScreen extends StatefulWidget {
  const RecenzijaDodajScreen({Key? key}) : super(key: key);
  static const String routeName = "/recenzija_dodaj";

  @override
  State<RecenzijaDodajScreen> createState() => _RecenzijaDodajScreenState();
}

class _RecenzijaDodajScreenState extends State<RecenzijaDodajScreen> {
  RecenzijaProvider? _recenzijaProvider;
  TextEditingController _recenzijaController = TextEditingController();
  int? rating = 3;

  @override
  void initState() {
    super.initState();
    _recenzijaProvider = context.read<RecenzijaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj recenziju"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Ocjena:',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RatingBar(
                            itemSize: 40,
                            maxRating: 5,
                            minRating: 1,
                            initialRating: 3,
                            allowHalfRating: false,
                            ratingWidget: RatingWidget(
                                full: Icon(Icons.star, color: Color.fromARGB(255, 253, 190, 0)),
                                half: Icon(Icons.star, color: Color.fromARGB(255, 253, 190, 0)),
                                empty: Icon(Icons.star, color: Colors.grey)),
                            onRatingUpdate: (rate) {
                              rating = rate.toInt();
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Sadržaj recenzije:',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        Container(
                            child: TextField(
                                controller: _recenzijaController,
                                style: TextStyle(fontSize: 18))),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  Map recenzija = {
                                    "korisnikID":
                                        Authorization.korisnik!.korisnikID,
                                    "sadrzajRecenzije":
                                        _recenzijaController.text,
                                    "ocjena": rating
                                  };

                                  await _recenzijaProvider!.insert(recenzija);
                                  Navigator.pop(context, true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Recenzija uspješno dodana!"), backgroundColor: Color.fromARGB(255, 46, 92, 232),));
                                },
                                child: Text("Dodaj recenziju",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        )
                      ]),
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }
}

import 'package:espacenter_mobile/screens/recenzija_detalji_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_dodaj_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/recenzija.dart';
import '../providers/recenzija_provider.dart';

class RecenzijaScreen extends StatefulWidget {
  const RecenzijaScreen({Key? key}): super(key: key);
  static const String routeName = "/recenzija";

  @override
  State<RecenzijaScreen> createState() => _RecenzijaScreenState();
}

class _RecenzijaScreenState extends State<RecenzijaScreen> {
RecenzijaProvider? _recenzijaProvider ;
  List<Recenzija> data = [];
  int? rating;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _recenzijaProvider!.get({'includeKorisnik':true});
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recenzije"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251)
      ),
      body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildRecenzije(),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var refresh = await Navigator.pushNamed(context, RecenzijaDodajScreen.routeName);
            if(refresh == true)
            {
              await loadData();
            }
          },
          backgroundColor: Color.fromARGB(255, 23, 121, 251),
          child: const Icon(Icons.add),
        )
    );
  }


  List<Widget> _buildRecenzije(){
    var list = data
        .map((e) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, "${RecenzijaDetaljiScreen.routeName}/${e.recenzijaID}");
          },
          child: 
        Card(
              shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                     Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                                "${e.korisnik!.ime} ${e.korisnik!.prezime}",
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              Container(
                                height: 20,
                              ),
                              Text(
                                "${e.sadrzajRecenzije}" , overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),)])),
                              Container(
                                height: 20,
                              ),
                              Container(child: RatingBar(
                      ignoreGestures: true,
                      itemSize:24,
                      maxRating: 5,
                      minRating: 1,
                      initialRating: e.ocjena!.toDouble(),
                      allowHalfRating: false,
                      ratingWidget: RatingWidget(full: Icon(Icons.star,color: Color.fromARGB(255, 253, 190, 0)),
                      half:Icon(Icons.star,color: Color.fromARGB(255, 253, 190, 0)) ,
                      empty:Icon(Icons.star,color: Colors.grey))
                    , onRatingUpdate: (rate){
                      rating = rate.toInt();
                    })),
                
                  ],
                ),
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}
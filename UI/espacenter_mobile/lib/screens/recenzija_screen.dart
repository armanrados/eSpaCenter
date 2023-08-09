import 'package:espacenter_mobile/screens/recenzija_detalji_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_dodaj_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
            child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: _buildRecenzije(),
              ),
            ))
          ]),
        )),
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
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${e.korisnik!.ime} ${e.korisnik!.prezime}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    RatingBar(
                      ignoreGestures: true,
                      itemSize:24,
                      maxRating: 5,
                      minRating: 1,
                      initialRating: e.ocjena!.toDouble(),
                      allowHalfRating: false,
                      ratingWidget: RatingWidget(full: Icon(Icons.star,color: Colors.amber),
                      half:Icon(Icons.star,color: Colors.amber) ,
                      empty:Icon(Icons.star,color: Colors.grey))
                    , onRatingUpdate: (rate){
                      rating = rate.toInt();
                    }),
                    SizedBox(height: 15,),
                    Expanded(child:Text("${e.sadrzajRecenzije}" , overflow: TextOverflow.ellipsis,) ,)
                  ],
                ),
              ),
            )),)
        .cast<Widget>()
        .toList();

    return list;
  }
}
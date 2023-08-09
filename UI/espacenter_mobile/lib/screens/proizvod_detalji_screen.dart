import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../providers/proizvod_provider.dart';
import '../utils/util.dart';

class ProizvodDetaljiScreen extends StatefulWidget {
  static const String routeName = "/proizvod_detalji";
  String id;
  ProizvodDetaljiScreen(this.id,{Key? key}) : super(key: key);

  @override
  State<ProizvodDetaljiScreen> createState() => _ProizvodDetaljiScreenState();
}

class _ProizvodDetaljiScreenState extends State<ProizvodDetaljiScreen> {
 ProizvodProvider? _proizvodProvider;
  Proizvod? _proizvod;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _proizvodProvider = context.read<ProizvodProvider>();
    loadData();
  }

    Future loadData() async {
     var tmp = await _proizvodProvider!.getById(int.parse(this.widget.id));
     setState(() {
      _proizvod = tmp;
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalji proizvoda"),backgroundColor: Color.fromARGB(255, 23, 121, 251),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ProizvodDetalji()
        ]),
      ),
    );
  }

  Widget ProizvodDetalji()
  {
    if(_proizvod == null)
    {
      return Center(child: Text("Učitavanje detalja"),);
    }

    else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(_proizvod?.naziv! ?? "N/A", style: TextStyle(fontSize: 36 , fontWeight: FontWeight.bold),),
                  SizedBox(height:15),
                  Container(
                    child: imageFromBase64String(_proizvod!.slika!),
                    width:300
                  ),
                  SizedBox(height:15),
                  Text("Cijena proizvoda: ${formatNumber(_proizvod?.cijena!)} KM" , style: TextStyle(fontSize: 20),),
                  SizedBox(height:15),
                  Row(children: [
                    Expanded(child: Container(child: Text("${_proizvod!.opis}" , style: TextStyle(fontSize: 16),)))
                  ],)]),
              )),
      );
    }
  }
}
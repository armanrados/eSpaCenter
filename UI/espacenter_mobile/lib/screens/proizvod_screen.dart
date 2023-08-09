import 'package:espacenter_mobile/screens/proizvod_detalji_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/proizvod.dart';
import '../providers/cart_provider.dart';
import '../providers/narudzba_provider.dart';
import '../providers/proizvod_provider.dart';
import '../utils/util.dart';
import 'cart_screen.dart';

class ProizvodScreen extends StatefulWidget {
  const ProizvodScreen({Key? key}): super(key: key);
  static const String routeName = "/proizvod";

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {
 TextEditingController _searchController = TextEditingController();
  ProizvodProvider? _proizvodProvider;
  CartProvider? _cartProvider;
  NarudzbaProvider? _narudzbaProvider;
  List<Proizvod> recommendedData = [];
  List<Proizvod> proizvodData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _proizvodProvider = context.read<ProizvodProvider>();
    _cartProvider = context.read<CartProvider>();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    loadData();
  }

  Future loadData() async {
    var narudzbe = await _narudzbaProvider!.get({
      'includeKorisnik':true,
      'includeNarudzbaProizvodi':true,
      'includeUplata':true
    });
    var korisnikNarudzbe = await _narudzbaProvider!.get({
      'korisnikID':Authorization.korisnik!.korisnikID,
      'includeKorisnik':true,
      'includeNarudzbaProizvodi':true,
      'includeUplata':true});
    List<Proizvod> tmpData = [];
    if(korisnikNarudzbe.length >= 1 && narudzbe.length >= 2)
    {
      tmpData = await _proizvodProvider!.Recommend();
    }
    else{
      tmpData = await _proizvodProvider!.get({'includeVrstaProizvoda':true, 'isDeleted': false});
    }
    setState((){
      if(korisnikNarudzbe.length >= 1 && narudzbe.length >= 2)
      {
        recommendedData = tmpData;
      }
      else{
        proizvodData = tmpData;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Proizvodi"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(children: [
            _buildProductSearch(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: 
                _buildProducts(),
          ),
            ))
          ]),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          backgroundColor: Color.fromARGB(255, 33, 103, 243),
          child: const Icon(Icons.shopping_cart),
        ));
  }

 

   Widget _buildProductSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Pretraži",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 33, 103, 243)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 33, 103, 243)),
                    borderRadius: BorderRadius.circular(10)) ,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color.fromARGB(255, 33, 103, 243)))),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: IconButton(
            icon: Icon(Icons.search_rounded, color: Color.fromARGB(255, 33, 103, 243),),
            onPressed: () async {
                var tmpData = await _proizvodProvider?.get({'naziv': _searchController.text});
                var tmpNarudzbe = await _narudzbaProvider?.get({
                  'includeKorisnik':true,
                  'includeNarudzbaProizvodi':true,
                  'includeUplata':true
                });
                setState(() {
                  if(_searchController.text != "")
                  {
                    proizvodData = tmpData!;
                  }
                  else if(tmpNarudzbe!.length < 2)
                  {
                    proizvodData = tmpData!;
                  }
                  else{
                    proizvodData = [];
                  }
                });
            },
          ),
        )
      ],
    );
  }

  List<Widget> _buildProducts() {
    List<Widget> list = [];

    if(proizvodData.isEmpty && recommendedData.isEmpty)
    {
      return [Text("Proizvodi se učitavaju...")];
    }
    if(proizvodData.isEmpty && _searchController.text == "")
    {
      list = recommendedData
        .map((e) => Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Preporucen proizvod"),
                    SizedBox(height: 5,),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                "${ProizvodDetaljiScreen.routeName}/${e.proizvodID}");
                          },
                          child: Container(
                            child: imageFromBase64String(e.slika!),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      e.naziv!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${formatNumber(e.cijena)} KM',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 33, 103, 243)
                        ),
                        onPressed: () {
                          _cartProvider?.addToCart(e);
                        },
                        icon: Icon(
                          // <-- Icon
                          Icons.shopping_cart,
                          size: 24.0,
                        ),
                        label: Text('Dodaj u korpu'), // <-- Text
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .cast<Widget>()
        .toList();
    }
    else{
      list = proizvodData
        .map((e) => Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                "${ProizvodDetaljiScreen.routeName}/${e.proizvodID}");
                          },
                          child: Container(
                            child: imageFromBase64String(e.slika!),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      e.naziv!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${formatNumber(e.cijena)} KM',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 33, 103, 243)
                        ),
                        onPressed: () {
                          _cartProvider?.addToCart(e);
                        },
                        icon: Icon(
                          // <-- Icon
                          Icons.shopping_cart,
                          size: 24.0,
                        ),
                        label: Text('Dodaj u korpu'), // <-- Text
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .cast<Widget>()
        .toList();
    }

    return list;
  }
}
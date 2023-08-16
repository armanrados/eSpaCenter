import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/uplata.dart';
import '../providers/cart_provider.dart';
import '../providers/narudzba_provider.dart';
import '../providers/uplata_provider.dart';
import '../utils/util.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}): super(key: key);
  static const String routeName = "/cart";


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  NarudzbaProvider? _narudzbaProvider;
  UplataProvider? _uplataProvider ;
  Map<String, dynamic>? paymentIntentData;
  Uplata? uplata ;
  double iznos = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _uplataProvider = context.read<UplataProvider>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moja korpa"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
      body: Column(
        children: [
          Expanded(child: _buildProductCardList()),
          if (_cartProvider.cart.items.isNotEmpty)
            TextButton(onPressed: () async{
              await makePayment(IzracunajUkupno());
            }, child: Text("Kupi" , style: TextStyle(color: Colors.black , fontSize: 18),)),
        ],
      ),
    );
  }

  double IzracunajUkupno()
  {
    _cartProvider.cart.items.forEach((element) {
      iznos += (element.proizvod.cijena! * element.count).toDouble();
    });

    return iznos;
  }

  Widget _buildProductCardList() {
    if (_cartProvider.cart.items.isEmpty) {
      return Center(
        child: Text("Korpa je trenutno prazna"),
      );
    }

    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          return _buildProductCard(_cartProvider.cart.items[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(CartItem item) {
    return ListTile(
      leading: imageFromBase64String(item.proizvod.slika!),
      title: Text("${item.proizvod.naziv} | Količina: ${item.count.toString()}"),
      subtitle: Text(
          "Cijena ${formatNumber(item.proizvod.cijena)} KM | Ukupno: ${formatNumber(item.proizvod.cijena! * item.count)} KM"),
      trailing: IconButton(
        onPressed: () {
          _cartProvider.removeFromCart(item.proizvod);
        },
        icon: Icon(Icons.delete),
        iconSize: 30.0,
        color: Colors.red,
      ),
    );
  }
  
  makePayment(double izracunajUkupno) {}
}
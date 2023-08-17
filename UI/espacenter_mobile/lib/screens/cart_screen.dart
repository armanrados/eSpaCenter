import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/uplata.dart';
import '../providers/cart_provider.dart';
import '../providers/narudzba_provider.dart';
import '../providers/uplata_provider.dart';
import '../utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../.env';
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
  Uplata? uplata;
  double iznos = 0;

  @override
  void initState() {
  
    super.initState();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _uplataProvider = context.read<UplataProvider>();
  }

  @override
  void didChangeDependencies() {
   
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
            ElevatedButton(onPressed: () async{
              await makePayment(IzracunajUkupno());
            }, child: Text("Naruči" , style: TextStyle(color: Colors.white , fontSize: 18),)),
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
        child: Text("Korpa je prazna!"),
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
  
  Future<void> makePayment(double iznos) async {
    try {
      paymentIntentData =
          await createPaymentIntent((iznos * 100).round().toString(), 'bam');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'eSpaCenter'))
          .then((value) {}).
          onError((error, stackTrace) {
          
            print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
          
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Text("Poništena transakcija!"),
                  ));
          throw Exception("Payment declined");
        });
        
          print("payment sheet created");
          print(paymentIntentData!['client_secret']);
        
        try {
          var tmp = await Stripe.instance.presentPaymentSheet();
          await InsertNarudzbe();
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Uplata uspješna!"), backgroundColor: Color.fromARGB(255, 46, 92, 232),));

        } catch (e) {
          
            print(e);
          
        }

    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  
  
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }
   insertUplata(double amount, String brojTransakcije) async {
      Map request = {
      "iznos": amount,
      "brojTransakcije": brojTransakcije,
    };

   uplata = await _uplataProvider!.insert(request);
  }

 

  Future<void> InsertNarudzbe() async {

    await insertUplata(iznos, paymentIntentData!['id']);

    List<Map> narudzbaProizvodi = [];
    _cartProvider.cart.items.forEach((element) {
      narudzbaProizvodi.add({
        "proizvodID" : element.proizvod.proizvodID,
        "kolicina" : element.count,
      });
    });
    Map narudzba = {
      "korisnikID" : Authorization.korisnik!.korisnikID,
      "uplataID" : uplata!.uplataID,
      "listaProizvoda": narudzbaProizvodi
    };

    await _narudzbaProvider!.insert(narudzba);
    setState(() {
      paymentIntentData = null;
      _cartProvider.cart.items.clear();
    });
  }
}
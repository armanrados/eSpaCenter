// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:espacenter_mobile/providers/cart_provider.dart';
import 'package:espacenter_mobile/providers/korisnik_provider.dart';
import 'package:espacenter_mobile/providers/narudzba_provider.dart';
import 'package:espacenter_mobile/providers/novosti_provider.dart';
import 'package:espacenter_mobile/providers/proizvod_provider.dart';
import 'package:espacenter_mobile/providers/recenzija_provider.dart';
import 'package:espacenter_mobile/providers/rezervacija_provider.dart';
import 'package:espacenter_mobile/providers/galerija_provider.dart';
import 'package:espacenter_mobile/providers/termin_provider.dart';
import 'package:espacenter_mobile/providers/uplata_provider.dart';
import 'package:espacenter_mobile/providers/usluga_provider.dart';
import 'package:espacenter_mobile/screens/cart_screen.dart';
import 'package:espacenter_mobile/screens/home_screen.dart';
import 'package:espacenter_mobile/screens/narudzbe_screen.dart';
import 'package:espacenter_mobile/screens/novosti_detalji_screen.dart';
import 'package:espacenter_mobile/screens/novosti_list_screen.dart';
import 'package:espacenter_mobile/screens/proizvod_detalji_screen.dart';
import 'package:espacenter_mobile/screens/profile_modify_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_detalji_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_dodaj_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_screen.dart';
import 'package:espacenter_mobile/screens/rezervacija_screen.dart';
import 'package:espacenter_mobile/screens/galerija_list_screen.dart';
import 'package:espacenter_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '.env';
void main() {
   WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey = stripePublishableKey; 

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => ProizvodProvider()),
      ChangeNotifierProvider(create: (_) => RecenzijaProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
      ChangeNotifierProvider(create: (_) => UslugaProvider()),
      ChangeNotifierProvider(create: (_) => GalerijaProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => UplataProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbaProvider()),
    
    ],
    child: MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(255, 255, 253, 253)),
      debugShowCheckedModeBanner: true,
      home: MyApp(),
      onGenerateRoute: (settings) {
        if (settings.name == NovostiListScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => NovostiListScreen()));
        }
        if (settings.name == GalerijaListScreen.routeName) {
          return MaterialPageRoute(
              builder: ((context) => GalerijaListScreen()));
        }
        if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => HomeScreen()));
        }
        if (settings.name == RezervacijaScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => RezervacijaScreen()));
        }
        if (settings.name == RecenzijaScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => RecenzijaScreen()));
        }
        if (settings.name == RecenzijaDodajScreen.routeName) {
          return MaterialPageRoute(
              builder: ((context) => RecenzijaDodajScreen()));
        }
        if (settings.name == CartScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => CartScreen()));
        }
        if (settings.name == NarudzbeScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => NarudzbeScreen()));
        }

        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == ProizvodDetaljiScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) => ProizvodDetaljiScreen(id));
        } else if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == NovostiDetaljiScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) => NovostiDetaljiScreen(id));
        } else if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == ProfileModifyScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) => ProfileModifyScreen(id));
        } else if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == RecenzijaDetaljiScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) => RecenzijaDetaljiScreen(id));
        }
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  late KorisnikProvider _korisnikProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.scaleDown)),
        child: Column(
          children: [
            SizedBox(
              height: 280,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Korisničko ime je obavezno!";
                        } else if (value.length < 3) {
                          return "Korisničko ime ne može imati manje od 3 slova";
                        }
                        return null;
                      },
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      controller: _username,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 177, 173, 173)
                              .withOpacity(0.3),
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Korisničko ime",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 11, 9, 0))),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lozinka ne moze biti prazno polje";
                        } else if (value.length < 4) {
                          return "Lozinka ne može imati manje od 4 slova";
                        }
                        return null;
                      },
                      obscureText: true,
                      style: TextStyle(color: Color.fromARGB(255, 1, 1, 0)),
                      controller: _password,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 177, 173, 173)
                              .withOpacity(0.3),
                          border: InputBorder.none,
                          hintText: "Lozinka",
                          filled: true,
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 4, 3, 0))),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          Authorization.username = _username.text;
                          Authorization.password = _password.text;

                          Authorization.korisnik =
                              await _korisnikProvider.Authenticate();
                          if (Authorization.korisnik?.isDeleted == true &&
                                  Authorization.korisnik?.roleNames
                                          ?.contains("Administrator") ==
                                      true ||
                              Authorization.korisnik?.roleNames
                                      ?.contains("Zaposlenik") ==
                                  true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Upozorenje'),
                                content: Text(
                                    "Neispravno korisničko ime ili lozinka!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert
                                    },
                                    child: Text('OK'),
                                  )
                                ],
                              ),
                            );
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName, (route) => false);
                          }
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Upozorenje"),
                                    content: Text(
                                        "Neispravno korisničko ime ili lozinka!"),
                                    actions: [
                                      TextButton(
                                        child: Text("Ok"),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  ));
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 46, 92, 232)),
                      child: Center(
                          child: const Text(
                        'Prijavi se',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14.0),
                      )),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    )));
  }
}

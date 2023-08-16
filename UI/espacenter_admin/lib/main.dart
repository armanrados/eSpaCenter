import 'package:espacenter_admin/providers/galerija_provider.dart';
import 'package:espacenter_admin/providers/korisnik_provider.dart';
import 'package:espacenter_admin/providers/narudzba_provider.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/providers/rezervacija_provider.dart';
import 'package:espacenter_admin/providers/termin_provider.dart';
import 'package:espacenter_admin/providers/uloga_provider.dart';
import 'package:espacenter_admin/providers/vrsta_proizvoda_provider.dart';
import 'package:espacenter_admin/screens/termini_sceen.dart';
import 'package:espacenter_admin/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProizvodProvider()),
      ChangeNotifierProvider(create: (_) => VrstaProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbaProvider()),
      ChangeNotifierProvider(create: (_) => GalerijaProvider()),
      ChangeNotifierProvider(create: (_) => NovostProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSpaCenter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  String? title;
  MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!);
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSpaCenter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late ProizvodProvider _proizvodProvider;
  late KorisnikProvider _korisnikProvider;

  @override
  Widget build(BuildContext context) {
    _proizvodProvider = context.read<ProizvodProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                  width: 180,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.people_alt)),
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Password", prefixIcon: Icon(Icons.password)),
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      _passwordController.text = username;

                      Authorization.username = username;
                      Authorization.password = password;
                      try {
                        Authorization.korisnik =
                            await _korisnikProvider.Authenticate();

                        if (Authorization.korisnik?.isDeleted == false &&
                                Authorization.korisnik?.roleNames
                                        ?.contains("Administrator") ==
                                    true ||
                            Authorization.korisnik?.roleNames
                                    ?.contains("Zaposlenik") ==
                                true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TerminiScreen(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Upozorenje'),
                              content: Text("Neispravno korisničko ime ili lozinka!"),
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
                        }
                      } on Exception catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Upozorenje"),
                                  content: Text(
                                      "Neispravno korisničko ime ili lozinka!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"))
                                  ],
                                ));
                      }
                    },
                    child: Text("Login"))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

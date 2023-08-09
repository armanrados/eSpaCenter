import 'package:espacenter_admin/screens/galerija_screen.dart';
import 'package:espacenter_admin/screens/historija_screen.dart';
import 'package:espacenter_admin/screens/narudzbe_screen.dart';
import 'package:espacenter_admin/screens/novosti_screen.dart';
import 'package:espacenter_admin/screens/proizvod_screen.dart';
import 'package:espacenter_admin/screens/rezervacije_screen.dart';
import 'package:espacenter_admin/screens/termini_sceen.dart';
import 'package:espacenter_admin/screens/zaposlenici_screen.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/util.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, Key? key}) : super(key: key);
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      drawer: Drawer(
        child: ListView(children: [
          SizedBox(height: 28),
          ListTile(
            title: Text("${Authorization.username}"),
            leading: Icon(Icons.account_circle, size: 50, color: Color.fromARGB(255, 23, 121, 251),),
            onTap: () {},
          ),
          Divider(
            height: 70,
          ),
          ListTile(
            title: Text("Termini"),
            leading: Icon(Icons.table_chart),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TerminiScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Rezervacije"),
            leading: Icon(Icons.punch_clock_rounded),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RezervacijeScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Proizvodi"),
            leading: Icon(Icons.shopping_bag),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProizvodScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Narudžbe"),
            leading: Icon(Icons.local_shipping),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NarudzbeScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Galerija"),
            leading: Icon(Icons.photo_sharp),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GalerijaScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Novosti"),
            leading: Icon(Icons.newspaper),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NovostScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Historija"),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistorijaScreen(),
              ));
            },
          ),
          if (Authorization.korisnik?.roleNames?.contains("Administrator") ==
              true)
            Visibility(
                visible: _isVisible,
                child: ListTile(
                  title: Text("Zaposlenici"),
                  leading: Icon(Icons.people_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ZaposleniciScreen(),
                    ));
                  },
                )),
          const SizedBox(
            height: 50,
            width: 20,
          ),
          ElevatedButton(
              child: const Text("Odjavi se"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              ))
        ]),
      ),
      body: widget.child!,
    );
  }
}

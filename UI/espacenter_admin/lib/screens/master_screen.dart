import 'package:espacenter_admin/screens/galerija_screen.dart';
import 'package:espacenter_admin/screens/historija_screen.dart';
import 'package:espacenter_admin/screens/narudzbe_screen.dart';
import 'package:espacenter_admin/screens/novosti_screen.dart';
import 'package:espacenter_admin/screens/product_detail_screen.dart';
import 'package:espacenter_admin/screens/proizvod_screen.dart';
import 'package:espacenter_admin/screens/rezervacije_screen.dart';
import 'package:espacenter_admin/screens/termini_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            title: Text("Termini"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TerminiScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Rezervacije"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RezervacijeScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Proizvodi"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProizvodScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Narudžbe"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NarudzbeScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Galerija"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GalerijaScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Novosti"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NovostiScreen(),
              ));
            },
          ),
          ListTile(
            title: Text("Historija"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistorijaScreen(),
              ));
            },
          ),
        ]),
      ),
      body: widget.child!,
    );
  }
}

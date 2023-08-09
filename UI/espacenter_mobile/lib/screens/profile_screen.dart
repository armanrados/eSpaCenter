import 'package:espacenter_mobile/screens/profile_modify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../providers/korisnik_provider.dart';
import '../utils/util.dart';
import 'narudzbe_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  KorisnikProvider? _korisnikProvider;
  Korisnik? korisnik;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    loadData();
  }

  Future loadData() async {
    var tmp =
        await _korisnikProvider!.getById(Authorization.korisnik!.korisnikID!);
    setState(() {
      korisnik = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Color.fromARGB(255, 23, 121, 251),
      ),
        body: SingleChildScrollView(
      child: Container(
        child: Column(children: [
         
          SizedBox(height: 40),
          Text("${Authorization.username}",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color:Colors.grey[900])),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: buildUser(),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var refresh = await Navigator.pushNamed(context,
                        "${ProfileModifyScreen.routeName}/${Authorization.korisnik!.korisnikID}");
                    if (refresh == true) {
                      await loadData();
                    }
                  },
                  child: Text("Uredi profil",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, NarudzbeScreen.routeName);
                  },
                  child: Text("Moje narudžbe",
                      style: TextStyle(color: Colors.white)))
            ],
          )
        ]),
      ),
    ));
  }



  Widget buildUser() {
    if (korisnik == null) {
      return Center(
        child: Text("Profil se učitava.."),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ime:', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Container(
              width: 320,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 33, 103, 243),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${korisnik!.ime}',
                      style: TextStyle(fontSize: 18)))),
          SizedBox(height: 16),
          Text('Prezime:', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Container(
              width: 320,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 33, 103, 243),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${korisnik!.prezime}',
                      style: TextStyle(fontSize: 18)))),
          SizedBox(height: 16),
          Text('Email:', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Container(
              width: 320,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 33, 103, 243),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${korisnik!.email}',
                      style: TextStyle(fontSize: 18)))),
          SizedBox(height: 16),
          Text('Datum rodjenja:', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Container(
              width: 320,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 33, 103, 243),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${formatDate(korisnik!.datumRodjenja!)}',
                      style: TextStyle(fontSize: 18)))),
          SizedBox(height: 16),
          Text('Broj telefona:', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Container(
              width: 320,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 33, 103, 243),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${korisnik!.telefon}',
                      style: TextStyle(fontSize: 18))))
        ],
      );
    }
  }
}

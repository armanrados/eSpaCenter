import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../providers/korisnik_provider.dart';
import '../utils/util.dart';

class ProfileModifyScreen extends StatefulWidget {
  static const String routeName = "/profile_modify";
  String id;
  ProfileModifyScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<ProfileModifyScreen> createState() => _ProfileModifyScreenState();
}

class _ProfileModifyScreenState extends State<ProfileModifyScreen> {
  KorisnikProvider? _korisnikProvider;

  Korisnik? _korisnik;

  TextEditingController _ImeController = TextEditingController();
  TextEditingController _PrezimeController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _TelefonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();

    loadData();
  }

  Future loadData() async {
    var tmpData = await _korisnikProvider!.getById(int.parse(this.widget.id));
    setState(() {
      _korisnik = tmpData;
      _EmailController.text = _korisnik!.email!;
      _ImeController.text = _korisnik!.ime!;
      _PrezimeController.text = _korisnik!.prezime!;
      _TelefonController.text = _korisnik!.telefon!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Moj profil"),
          backgroundColor: Color.fromARGB(255, 23, 121, 251),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buildProfile(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map user = {
                              "ime": _ImeController.text,
                              "prezime": _PrezimeController.text,
                              "email": _EmailController.text,
                              "telefon": _TelefonController.text,
                            };
                            await _korisnikProvider!.update(
                                Authorization.korisnik!.korisnikID!, user);
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Profil uspjesno uredjen")));
                          }
                        },
                        child: Text("Spasi promjene",
                            style: TextStyle(color: Colors.white)))
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  Widget buildProfile() {
    if (_korisnik == null) {
      return Center(
        child: Text("Loading"),
      );
    } else {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                children: [
                  Text('Ime:', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
                width: 320,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ime ne smije ostati prazno polje";
                          } else if (value.length < 3) {
                            return "Ime ne smije sadrzavati manje od 3 slova";
                          }
                          return null;
                        },
                        controller: _ImeController,
                        style: TextStyle(fontSize: 18)))),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                children: [
                  Text('Prezime:',
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
                width: 320,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Prezime ne smije ostati prazno polje";
                          } else if (value.length < 3) {
                            return "Prezime ne smije sadrzavati manje od 3 slova";
                          }
                          return null;
                        },
                        controller: _PrezimeController,
                        style: TextStyle(fontSize: 18)))),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                children: [
                  Text('Email:', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
                width: 320,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email ne smije ostati prazno polje";
                          }
                        },
                        controller: _EmailController,
                        style: TextStyle(fontSize: 18)))),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                children: [
                  Text('Broj telefona:',
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
                width: 320,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                        controller: _TelefonController,
                        style: TextStyle(fontSize: 18)))),
          ],
        ),
      );
    }
  }
}

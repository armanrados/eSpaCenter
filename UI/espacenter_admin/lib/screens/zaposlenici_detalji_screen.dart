// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:espacenter_admin/models/korisnik.dart';
import 'package:espacenter_admin/models/uloga.dart';
import 'package:espacenter_admin/providers/korisnik_provider.dart';
import 'package:espacenter_admin/providers/uloga_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/zaposlenici_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class ZaposleniciDetaljiScreen extends StatefulWidget {
  Korisnik? korisnik;
  ZaposleniciDetaljiScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<ZaposleniciDetaljiScreen> createState() => _ZaposleniciDetaljiScreenState();
}

class _ZaposleniciDetaljiScreenState extends State<ZaposleniciDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late KorisnikProvider _korisnikProvider;
  late UlogaProvider _ulogaProvider;



  SearchResult<Uloga>? ulogaResult;
  bool isLoading = true;  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'ime' : widget.korisnik?.ime,
      'prezime' : widget.korisnik?.prezime,
      'email' : widget.korisnik?.email,
      'telefon' : widget.korisnik?.telefon,
      'datumRodjenja' : widget.korisnik?.datumRodjenja.toString(),
      'ulogaID' : widget.korisnik?.ulogaID.toString(),
      'lozinka' : widget.korisnik?.lozinka
    };
        _korisnikProvider = context.read<KorisnikProvider>();
        _ulogaProvider = context.read<UlogaProvider>();

  initForm();
   
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }

    Future initForm() async {
   
    ulogaResult = await _ulogaProvider.get();
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          isLoading ? Container() : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.saveAndValidate();

                   
                      var request = Map.from(_formKey.currentState!.value);

                      

                
                      try {
                        if (widget.korisnik == null) {
                          await _korisnikProvider.insert(request);
                        } else {
                          await _korisnikProvider.update(
                              widget.korisnik!.korisnikID!, request);
                        }
                      } on Exception catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"))
                                  ],
                                ));
                      }
                       Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ZaposleniciScreen(),
                      ));
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: widget.korisnik?.korisnickoIme ?? "Detalji Zaposlenika",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(children: [
        Row(
          children: [
          
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Korisničko ime"),
                name: "korisnickoIme",
              ),
            ),
            SizedBox(width: 10,),
             Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Lozinka"),
                name: "lozinka",
              ),
            ),
          ],
      ),
       Row(
          children: [
          
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Ime"),
                name: "ime",
              ),
            ),
            SizedBox(width: 10,),
             Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Prezime"),
                name: "prezime",
              ),
            ),
          ],
      ),
          Row(
          children: [
          
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Telefon"),
                name: "telefon",
              ),
            ),
            SizedBox(width: 10,),
             Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Datum rodjenja"),
                name: "datumRodjenja",
              ),
            ),
          ],
      ),
            Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Email"),
                name: "email",
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: FormBuilderDropdown<String>(
              name: 'ulogeID',
              decoration: InputDecoration(
                labelText: 'Uloga',
                suffix: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _formKey.currentState!.fields['ulogeID']?.reset();
                  },
                ),
                hintText: 'Uloga',
              ),
              items:  ulogaResult?.result
                      .map((item) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: item.ulogaID.toString(),
                            child: Text(item.naziv ?? ""),
                          ))
                      .toList() ??
                  [],
            )),
          ],
      ),
      
      ]));
       
      
}
}

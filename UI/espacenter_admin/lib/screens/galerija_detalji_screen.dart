// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:espacenter_admin/models/galerija.dart';
import 'package:espacenter_admin/providers/galerija_provider.dart';
import 'package:espacenter_admin/screens/galerija_screen.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class GalerijaDetaljiScreen extends StatefulWidget {
  Galerija? galerija;
  GalerijaDetaljiScreen({Key? key, this.galerija}) : super(key: key);

  @override
  State<GalerijaDetaljiScreen> createState() => _GalerijaDetaljiScreenState();
}

class _GalerijaDetaljiScreenState extends State<GalerijaDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late GalerijaProvider _galerijaProvider;
  bool _imageSelected = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'galerijaID': widget.galerija?.galerijaID,
      'opis': widget.galerija?.opis,
      'korisnikID': widget.galerija?.korisnikID.toString()
    };

    _galerijaProvider = context.read<GalerijaProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
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

                      if (!_imageSelected) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text("Slika je obavezna!"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              )
                            ],
                          ),
                        );
                        return;
                      }

                      var request = Map.from(_formKey.currentState!.value);

                      request['slikaByte'] = _base64Image;

                      try {
                        if (widget.galerija == null) {
                          await _galerijaProvider.insert(request);
                        } else {
                          await _galerijaProvider.update(
                              widget.galerija!.galerijaID!, request);
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
                        builder: (context) => const GalerijaScreen(),
                      ));
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: "Detalji galerija",
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
                child: FormBuilderField(
              name: 'imageId',
              builder: ((field) {
                return InputDecorator(
                  decoration: InputDecoration(
                      label: Text('Slika'), errorText: field.errorText),
                  child: ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("Odaberite sliku"),
                    trailing: Icon(Icons.file_upload),
                    onTap: getImage,
                  ),
                );
              }),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Opis"),
                name: "opis",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(
                    labelText: "ID Zaposlenika",
                    hintText: "Unesite ID u stilu: 1 "),
                name: "korisnikID",
              ),
            ),
          ],
        )
      ]),
    );
  }

  File? _image;
  String? _base64Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      _imageSelected = true;
      setState(() {});
    }
  }
}

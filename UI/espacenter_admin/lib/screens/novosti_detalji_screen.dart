// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:espacenter_admin/models/novosti.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/novosti_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:espacenter_admin/utils/util.dart';


class NovostiDetaljiScreen extends StatefulWidget {
  Novosti? novosti;
  NovostiDetaljiScreen({Key? key, this.novosti}) : super(key: key);

  @override
  State<NovostiDetaljiScreen> createState() => _NovostiDetaljiScreenState();
}

class _NovostiDetaljiScreenState extends State<NovostiDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late NovostProvider _novostProvider;

  bool isLoading = true;
  bool _imageSelected = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'novostiID': widget.novosti?.novostiID,
      'naslov': widget.novosti?.naslov,
      'sadrzaj': widget.novosti?.sadrzaj,
      'korisnikID': Authorization.korisnik?.korisnikID.toString()
    };

    _novostProvider = context.read<NovostProvider>();
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

                      request['slika'] = _base64Image;
                      if (!_validateNaslov(request['naslov'])) {
                        _showNaslovWarning();
                        return;
                      }
                      if (!_validateSadrzaj(request['sadrzaj'])) {
                        _showSadrzajWarning();
                        return;
                      }
                      if (!_validateKorisnikID(request['korisnikID'])) {
                        _showKorisnikIDWarning();
                        return;
                      }

                      try {
                        if (widget.novosti == null) {
                          await _novostProvider.insert(request);
                        } else {
                          await _novostProvider.update(
                              widget.novosti!.novostiID!, request);
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
                        builder: (context) => const NovostScreen(),
                      ));
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: "Detalji novosti",
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
                decoration: InputDecoration(labelText: "Naslov"),
                name: "naslov",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Sadržaj"),
                name: "sadrzaj",
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
                    hintText: "Unesite ID u stilu: 1"),
                name: "korisnikID",
                enabled: false,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  bool _validateNaslov(String? naslov) {
    return naslov != null && naslov.isNotEmpty;
  }

  bool _validateSadrzaj(String? sadrzaj) {
    return sadrzaj != null && sadrzaj.isNotEmpty;
  }

  bool _validateKorisnikID(String? korisnikID) {
    if (korisnikID == null || korisnikID.isEmpty) {
      return false; // Empty ID is not allowed.
    }

    // Use a regular expression to check if it's a non-negative integer.
    final idPattern = r'^\d+$';
    if (!RegExp(idPattern).hasMatch(korisnikID)) {
      return false; // Not a non-negative integer.
    }

    // Convert the string to an integer and check if it's non-negative.
    final id = int.tryParse(korisnikID);
    return id != null && id >= 0;
  }

  void _showNaslovWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Naslov je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSadrzajWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Sadržaj je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showKorisnikIDWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Unesite validan ID."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
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

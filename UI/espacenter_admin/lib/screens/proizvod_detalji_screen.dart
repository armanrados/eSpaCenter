// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:espacenter_admin/models/proizvod.dart';
import 'package:espacenter_admin/models/vrsta_proizvoda.dart';
import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/providers/vrsta_proizvoda_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/proizvod_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class ProizvodDetaljiScreen extends StatefulWidget {
  Proizvod? proizvod;
  ProizvodDetaljiScreen({Key? key, this.proizvod}) : super(key: key);

  @override
  State<ProizvodDetaljiScreen> createState() => _ProizvodDetaljiScreenState();
}

class _ProizvodDetaljiScreenState extends State<ProizvodDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late VrstaProizvodaProvider _vrstaProizvodaProvider;
  late ProizvodProvider _proizvodProvider;

  SearchResult<VrstaProizvoda>? vrstaProizvodaResult;
  bool isLoading = true;
  bool _imageSelected = false;
  @override
  void initState() {
    super.initState();
    _initialValue = {
      'sifra': widget.proizvod?.sifra,
      'naziv': widget.proizvod?.naziv,
      'cijena': widget.proizvod?.cijena?.toString(),
      'opis': widget.proizvod?.opis,
      'vrstaProizvodaID': widget.proizvod?.vrstaProizvodaID?.toString(),
    };

    _vrstaProizvodaProvider = context.read<VrstaProizvodaProvider>();
    _proizvodProvider = context.read<ProizvodProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    vrstaProizvodaResult = await _vrstaProizvodaProvider.get();

    print(vrstaProizvodaResult);

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
                      if (!_validateNaziv(request['naziv'])) {
                        _showNazivWarning();
                        return;
                      }
                      if (!_validateCijena(request['cijena'])) {
                        _showCijenaWarning();
                        return;
                      }
                      if (!_validateOpis(request['opis'])) {
                        _showOpisWarning();
                        return;
                      }
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
                      if (_formKey.currentState?.fields['vrstaproizvodaId']
                              ?.value ==
                          null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text("Vrsta proizvoda je obavezna!"),
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
                      request['slika'] = _base64Image;

                      try {
                        if (widget.proizvod == null) {
                          await _proizvodProvider.insert(request);
                        } else {
                          await _proizvodProvider.update(
                              widget.proizvod!.proizvodID!, request);
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
                        builder: (context) => const ProizvodScreen(),
                      ));
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: this.widget.proizvod?.naziv ?? "Detalji proizvoda",
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
                decoration: InputDecoration(labelText: "Naziv"),
                name: "naziv",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Cijena"),
                name: "cijena",
              ),
            ),
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
                child: FormBuilderDropdown<String>(
              name: 'vrstaproizvodaId',
              decoration: InputDecoration(
                labelText: 'Vrsta proizvoda',
                suffix: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _formKey.currentState!.fields['vrstaproizvodaId']?.reset();
                  },
                ),
                hintText: 'Vrsta proizvoda',
              ),
              items: vrstaProizvodaResult?.result
                      .map((item) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: item.vrstaProizvodaID.toString(),
                            child: Text(item.naziv ?? ""),
                          ))
                      .toList() ??
                  [],
            )),
          ],
        )
      ]),
    );
  }

  bool _validateNaziv(String? naziv) {
    return naziv != null && naziv.isNotEmpty;
  }

  bool _validateCijena(String? cijena) {
    if (cijena == null || cijena.isEmpty) {
      return false; // Empty cijena is not allowed.
    }
    try {
      // Attempt to parse cijena as a double or int
      double.parse(cijena);
      return true; // Successfully parsed as double
    } catch (e) {
      try {
        int.parse(cijena);
        return true; // Successfully parsed as int
      } catch (e) {
        return false; // Not a valid double or int
      }
    }
  }

  bool _validateOpis(String? opis) {
    return opis != null && opis.isNotEmpty;
  }

  void _showNazivWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Naziv je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showCijenaWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Molimo unesite cijenu izraženu u brojevima."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showOpisWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Opis je obavezan!"),
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

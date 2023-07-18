// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:espacenter_admin/models/novost.dart';
import 'package:espacenter_admin/providers/novost_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class NovostiDetaljiScreen extends StatefulWidget {
  Novost? novost;
  NovostiDetaljiScreen({Key? key, this.novost}) : super(key: key);

  @override
  State<NovostiDetaljiScreen> createState() => _NovostiDetaljiScreenState();
}

class _NovostiDetaljiScreenState extends State<NovostiDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late NovostProvider _novostProvider;


  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'slika': widget.novost?.slika,
      'naslov': widget.novost?.naslov,
      'sadrzaj': widget.novost?.sadrzaj,
    };

    _novostProvider = context.read<NovostProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (widget.product != null) {
    //   setState(() {
    //     _formKey.currentState?.patchValue({'sifra': widget.product?.sifra});
    //   });
    // }
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


                      var request = Map.from(_formKey.currentState!.value);

                      request['slika'] = _base64Image;

                      print(request['slika']);

                      try {
                        if (widget.novost == null) {
                          await _novostProvider.insert(request);
                        } else {
                          await _novostProvider.update(
                              widget.novost!.novostID!, request);
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
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: this.widget.novost?.naslov ?? "Detalji novosti",
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
                      label: Text('Slika'),
                      errorText: field.errorText),
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
    }
  }
}

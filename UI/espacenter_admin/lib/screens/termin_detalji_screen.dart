// ignore_for_file: prefer_const_constructors
import 'package:espacenter_admin/models/termin.dart';
import 'package:espacenter_admin/providers/termin_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/termini_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';


class TerminDetaljiScreen extends StatefulWidget {
  Termin? termin;
  TerminDetaljiScreen({Key? key, this.termin}) : super(key: key);

  @override
  State<TerminDetaljiScreen> createState() => _TerminDetaljiScreenState();
}

class _TerminDetaljiScreenState extends State<TerminDetaljiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  late TerminProvider _terminProvider;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'korisnikID': widget.termin?.korisnikID.toString(),
      'datumTermina':widget.termin?.datumTermina?.toIso8601String(),
      'vrijemeTermina': widget.termin?.vrijemeTermina,
    };
    _terminProvider = context.read<TerminProvider>();

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

                      var request = Map.from(_formKey.currentState!.value);

                      try {
                        if (widget.termin == null) {
                          await _terminProvider.insert(request);
                        } else {
                          await _terminProvider.update(
                              widget.termin!.terminID!, request);
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
                        builder: (context) => const TerminiScreen(),
                      ));
                    },
                    child: Text("Sačuvaj")),
              )
            ],
          )
        ],
      ),
      title: "Detalji termina",
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
                  decoration: InputDecoration(labelText: "Zaposlenik"),
                  name: "korisnikID",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Datum Termina"),
                  name: "datumTermina",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Vrijeme Termina"),
                  name: "vrijemeTermina",
                ),
              ),
            ],
          )
        ]));
  }
}


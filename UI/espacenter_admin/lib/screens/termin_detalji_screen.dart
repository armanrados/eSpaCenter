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
    super.initState();
    _initialValue = {
      'korisnikID': widget.termin?.korisnikID.toString(),
      'datumTermina': widget.termin?.datumTermina?.toIso8601String(),
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
                      if (!_validateKorisnikID(request['korisnikID'])) {
                        _showKorisnikIDWarning();
                        return;
                      }
                      if (!_validateDateFormat(request['datumTermina'])) {
                        _showDateFormatWarning();
                        return;
                      }

                      if (!_validateTimeFormat(request['vrijemeTermina'])) {
                        _showTimeFormatWarning();
                        return;
                      }

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
                  decoration: InputDecoration(
                      labelText: "ID Zaposlenika",
                      hintText: "Unesite ID u stilu: 1"),
                  name: "korisnikID",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(
                      labelText: "Datum termina",
                      hintText: "Unesite datum u stilu: YYYY-MM-DD"),
                  name: "datumTermina",
                  initialValue: _initialValue['datumTermina'] != null
                      ? _formatDateString(_initialValue['datumTermina'])
                      : null,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(
                      labelText: "Vrijeme Termina",
                      hintText: "Unesite vrijeme termina u stilu: 10:00"),
                  name: "vrijemeTermina",
                ),
              ),
            ],
          )
        ]));
  }

  bool _validateDateFormat(String? date) {
    final datePattern = r'^\d{4}-\d{2}-\d{2}$';
    return RegExp(datePattern).hasMatch(date ?? '');
  }

  bool _validateTimeFormat(String? time) {
    final timePattern = r'^\d{2}:\d{2}$';
    return RegExp(timePattern).hasMatch(time ?? '');
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

  void _showDateFormatWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Unesite validan datum u ovom stilu: YYYY-MM-DD."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showTimeFormatWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Unesite validno vrijeme u ovom stilu: HH:MM."),
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

  String _formatDateString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
}

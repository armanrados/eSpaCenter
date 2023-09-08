// ignore_for_file: prefer_const_constructors
import 'package:espacenter_admin/models/korisnik.dart';
import 'package:espacenter_admin/models/uloga.dart';
import 'package:espacenter_admin/providers/korisnik_provider.dart';
import 'package:espacenter_admin/providers/uloga_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/zaposlenici_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class ZaposleniciDetaljiScreen extends StatefulWidget {
  Korisnik? korisnik;
  ZaposleniciDetaljiScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<ZaposleniciDetaljiScreen> createState() =>
      _ZaposleniciDetaljiScreenState();
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
    super.initState();
    _initialValue = {
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'ime': widget.korisnik?.ime,
      'prezime': widget.korisnik?.prezime,
      'email': widget.korisnik?.email,
      'telefon': widget.korisnik?.telefon,
      'datumRodjenja': widget.korisnik?.datumRodjenja.toString(),
      'ulogaID': widget.korisnik?.ulogaID.toString(),
      'lozinka': widget.korisnik?.lozinka
    };
    _korisnikProvider = context.read<KorisnikProvider>();
    _ulogaProvider = context.read<UlogaProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
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
                      if (!_validateKorisnickoIme(request['korisnickoIme'])) {
                        _showKorisnickoImeWarning();
                        return;
                      }
                      if (!_validateLozinka(request['lozinka'])) {
                        _showLozinkaWarning();
                        return;
                      }
                      if (!_validateIme(request['ime'])) {
                        _showImeWarning();
                        return;
                      }
                      if (!_validatePrezime(request['prezime'])) {
                        _showPrezimeWarning();
                        return;
                      }
                      if (!_validateTelefon(request['telefon'])) {
                        _showTelefonWarning();
                        return;
                      }
                      if (!_validateDatumRodjenja(request['datumRodjenja'])) {
                        _showDatumRodjenjaWarning();
                        return;
                      }
                      if (!_validateEmail(request['email'])) {
                        _showEmailWarning();
                        return;
                      }

                      if (_formKey.currentState?.fields['ulogeID']?.value ==
                          null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text("Uloga je obavezna!"),
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

                      try {
                        Korisnik updatedEmployee;
                        updatedEmployee =
                            await _korisnikProvider.insert(request);

                        Navigator.pop(context, updatedEmployee);
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
            ],
          ),
          Row(
            children: [
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
            ],
          ),
          Row(
            children: [
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(
                      labelText: "Datum rođenja",
                      hintText: "Unesite datum u stilu: YYYY-MM-DD"),
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
            ],
          ),
          Row(
            children: [
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
                items: ulogaResult?.result
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

  bool _validateKorisnickoIme(String? korisnickoIme) {
    return korisnickoIme != null &&
        korisnickoIme.isNotEmpty &&
        korisnickoIme.length >= 4;
  }

  bool _validateIme(String? ime) {
    return ime != null && ime.isNotEmpty && ime.length >= 2;
  }

  bool _validatePrezime(String? prezime) {
    return prezime != null && prezime.isNotEmpty && prezime.length >= 2;
  }

  bool _validateEmail(String? email) {
    return email != null && email.isNotEmpty;
  }

  bool _validateTelefon(String? telefon) {
    if (telefon == null || telefon.isEmpty) {
      return false; // Empty telefon is not allowed.
    }
    try {
      int.parse(telefon);
      return true; // Successfully parsed as an integer.
    } catch (e) {
      return false; // Not a valid integer.
    }
  }

  bool _validateLozinka(String? lozinka) {
    return lozinka != null && lozinka.isNotEmpty && lozinka.length >= 4;
  }

  bool _validateDatumRodjenja(String? datumRodjenja) {
    final datePattern = r'^\d{4}-\d{2}-\d{2}$';
    return RegExp(datePattern).hasMatch(datumRodjenja ?? '');
  }

  void _showKorisnickoImeWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text(
            "Korisničko ime je obavezno i mora imati minimalno 4 karaktera!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showImeWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Ime je obavezno i mora imati minimalno 2 karaktera!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showPrezimeWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content:
            Text("Prezime je obavezno i mora imati minimalno 2 karaktera!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showTelefonWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Broj telefona je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showEmailWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Email je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showLozinkaWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content:
            Text("Lozinka je obavezna i mora imati minimalno 4 karaktera!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showDatumRodjenjaWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Upozorenje"),
        content: Text("Datum rođenja je obavezan!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/korisnik.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
    KorisnikProvider(): super("Korisnik");

   @override
   Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }
   Future <Korisnik> Authenticate() async
  {
    var url = "$fullUrl/Authenticate";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http.get(uri , headers: headers);
    if(isValidResponse(response)){
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      return user;
    }
    else{
      throw Exception("Pogrešno korisničko ime ili lozinka");
    }
  }
}
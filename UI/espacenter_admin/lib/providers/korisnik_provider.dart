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
}
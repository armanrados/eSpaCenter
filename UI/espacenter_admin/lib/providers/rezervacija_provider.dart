import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/rezervacija.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija> {
    RezervacijaProvider(): super("Rezervacija");

   @override
   Rezervacija fromJson(data) {
    // TODO: implement fromJson
    return Rezervacija.fromJson(data);
  }
}
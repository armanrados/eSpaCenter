import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/narudzba.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class NarudzbaProvider extends BaseProvider<Narudzba> {
    NarudzbaProvider(): super("Narudzba");

   @override
   Narudzba fromJson(data) {
    // TODO: implement fromJson
    return Narudzba.fromJson(data);
  }
}
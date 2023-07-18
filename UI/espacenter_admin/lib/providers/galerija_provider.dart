import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/galerija.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class GalerijaProvider extends BaseProvider<Galerija> {
    GalerijaProvider(): super("Galerija");

   @override
   Galerija fromJson(data) {
    // TODO: implement fromJson
    return Galerija.fromJson(data);
  }
}
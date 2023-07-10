import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/proizvod.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class ProizvodProvider extends BaseProvider<Proizvod> {
  ProizvodProvider(): super("Proizvod");

   @override
  Proizvod fromJson(data) {
    // TODO: implement fromJson
    return Proizvod.fromJson(data);
  }
}
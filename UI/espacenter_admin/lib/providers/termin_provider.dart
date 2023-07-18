import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/termin.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider(): super("Termin");

   @override
  Termin fromJson(data) {
    // TODO: implement fromJson
    return Termin.fromJson(data);
  }
}
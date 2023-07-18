import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/novost.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class NovostProvider extends BaseProvider<Novost> {
    NovostProvider(): super("Novosti");

   @override
   Novost fromJson(data) {
    // TODO: implement fromJson
    return Novost.fromJson(data);
  }
}
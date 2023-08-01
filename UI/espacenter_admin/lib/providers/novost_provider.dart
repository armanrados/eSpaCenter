import 'dart:convert';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:espacenter_admin/models/novosti.dart';

import 'package:http/http.dart' as http;

import 'base_provider.dart';

class NovostProvider extends BaseProvider<Novosti> {
    NovostProvider(): super("Novosti");

   @override
   Novosti fromJson(data) {
    // TODO: implement fromJson
    return Novosti.fromJson(data);
  }
}
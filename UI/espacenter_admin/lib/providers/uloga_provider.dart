import 'dart:convert';

import 'package:espacenter_admin/models/uloga.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/base_provider.dart';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider(): super("Uloga");

  @override
  Uloga fromJson(data) {
    // TODO: implement fromJson
    return Uloga.fromJson(data);
  }


}
import 'dart:convert';

import 'package:espacenter_admin/models/proizvod.dart';
import 'package:espacenter_admin/models/search_result.dart';
import 'package:espacenter_admin/providers/base_provider.dart';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import '../models/vrsta_proizvoda.dart';

class VrstaProizvodaProvider extends BaseProvider<VrstaProizvoda> {
  VrstaProizvodaProvider(): super("VrstaProizvoda");

  @override
  VrstaProizvoda fromJson(data) {
    // TODO: implement fromJson
    return VrstaProizvoda.fromJson(data);
  }


}
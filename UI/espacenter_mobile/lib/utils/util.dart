import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/korisnik.dart';


class Authorization {
  static String? username;
  static String? password;
  static Korisnik? korisnik;

}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
String formatDate(DateTime date) => new DateFormat("dd/MM/yyyy").format(date);


String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  
  return f.format(dynamic);
}

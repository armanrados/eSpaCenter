import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/korisnik.dart';
import '../models/uloga.dart';

class Authorization
{
  static String? username;
  static String? password;
  static Korisnik? korisnik;
  static Uloga? uloga;

}
Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}
String formatDate(DateTime date) => new DateFormat("dd/MM/yyyy").format(date);

String formatNumber(dynamic) {
  var f = NumberFormat('####,00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}
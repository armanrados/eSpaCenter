import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'korisnik.dart';

part 'recenzija.g.dart';

@JsonSerializable()
class Recenzija{
  int? recenzijaID;
  String? sadrzajRecenzije;
  int? ocjena;
  DateTime? datumKreiranja;
  int? korisnikID;
  Korisnik? korisnik;

  Recenzija(this.recenzijaID,this.sadrzajRecenzije,this.ocjena,this.datumKreiranja,this.korisnik,this.korisnikID);

  factory Recenzija.fromJson(Map<String, dynamic> json) => _$RecenzijaFromJson(json);

    Map<String, dynamic> toJson() => _$RecenzijaToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzija _$RecenzijaFromJson(Map<String, dynamic> json) => Recenzija(
      json['recenzijaID'] as int?,
      json['sadrzajRecenzije'] as String?,
      json['ocjena'] as int?,
      json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      json['korisnikID'] as int?,
    );

Map<String, dynamic> _$RecenzijaToJson(Recenzija instance) => <String, dynamic>{
      'recenzijaID': instance.recenzijaID,
      'sadrzajRecenzije': instance.sadrzajRecenzije,
      'ocjena': instance.ocjena,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
      'korisnikID': instance.korisnikID,
      'korisnik': instance.korisnik,
    };

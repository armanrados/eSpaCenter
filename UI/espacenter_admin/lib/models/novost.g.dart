// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novost _$NovostFromJson(Map<String, dynamic> json) => Novost(
      json['novostID'] as int?,
      json['slika'] as String?,
      json['sadrzaj'] as String?,
      json['naslov'] as String?,
      json['korisnikID'] as int?,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NovostToJson(Novost instance) => <String, dynamic>{
      'novostID': instance.novostID,
      'slika': instance.slika,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'korisnikID': instance.korisnikID,
      'korisnik': instance.korisnik,
    };

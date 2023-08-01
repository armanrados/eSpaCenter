// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novosti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novosti _$NovostiFromJson(Map<String, dynamic> json) => Novosti(
      json['novostiID'] as int?,
      json['slika'] as String?,
      json['sadrzaj'] as String?,
      json['naslov'] as String?,
      json['korisnikID'] as int?,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$NovostiToJson(Novosti instance) => <String, dynamic>{
      'novostiID': instance.novostiID,
      'slika': instance.slika,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'korisnikID': instance.korisnikID,
      'korisnik': instance.korisnik,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
      'isVisible': instance.isVisible,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'galerija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Galerija _$GalerijaFromJson(Map<String, dynamic> json) => Galerija(
      json['galerijaID'] as int?,
      json['slikaByte'] as String?,
      json['opis'] as String?,
      json['korisnikID'] as int?,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$GalerijaToJson(Galerija instance) => <String, dynamic>{
      'galerijaID': instance.galerijaID,
      'slikaByte': instance.slikaByte,
      'opis': instance.opis,
      'korisnikID': instance.korisnikID,
      'korisnik': instance.korisnik,
      'isVisible': instance.isVisible,
    };

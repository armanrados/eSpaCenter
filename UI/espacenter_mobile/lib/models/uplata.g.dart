// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uplata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uplata _$UplataFromJson(Map<String, dynamic> json) => Uplata(
      json['uplataID'] as int?,
      (json['iznos'] as num?)?.toDouble(),
      json['datumTransakcije'] == null
          ? null
          : DateTime.parse(json['datumTransakcije'] as String),
      json['brojTransakcije'] as String?,
      json['korisnikID'] as int?,
    );

Map<String, dynamic> _$UplataToJson(Uplata instance) => <String, dynamic>{
      'uplataID': instance.uplataID,
      'iznos': instance.iznos,
      'datumTransakcije': instance.datumTransakcije?.toIso8601String(),
      'brojTransakcije': instance.brojTransakcije,
      'korisnikID': instance.korisnikID,
    };

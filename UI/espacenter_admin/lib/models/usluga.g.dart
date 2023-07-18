// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usluga _$UslugaFromJson(Map<String, dynamic> json) => Usluga(
      json['uslugaID'] as int?,
      json['naziv'] as String?,
      json['opis'] as String?,
    );

Map<String, dynamic> _$UslugaToJson(Usluga instance) => <String, dynamic>{
      'uslugaID': instance.uslugaID,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proizvod _$ProizvodFromJson(Map<String, dynamic> json) => Proizvod(
      json['proizvodID'] as int?,
      json['naziv'] as String?,
      json['sifra'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['slika'] as String?,
      json['vrstaProizvodaID'] as int?,
      json['isDeleted'] as bool?,
    )..opis = json['opis'] as String?;

Map<String, dynamic> _$ProizvodToJson(Proizvod instance) => <String, dynamic>{
      'proizvodID': instance.proizvodID,
      'naziv': instance.naziv,
      'sifra': instance.sifra,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'opis': instance.opis,
      'isDeleted': instance.isDeleted,
      'vrstaProizvodaID': instance.vrstaProizvodaID,
    };

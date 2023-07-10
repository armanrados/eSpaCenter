// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proizvod _$ProizvodFromJson(Map<String, dynamic> json) => Proizvod(
      json['proizvodId'] as int?,
      json['naziv'] as String?,
      json['sifra'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['slika'] as String?,
      json['vrstaproizvodaId'] as int?,
    )..opis = json['opis'] as String?;

Map<String, dynamic> _$ProizvodToJson(Proizvod instance) => <String, dynamic>{
      'proizvodId': instance.proizvodId,
      'naziv': instance.naziv,
      'sifra': instance.sifra,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'opis': instance.opis,
      'vrstaproizvodaId': instance.vrstaproizvodaId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba_proizvodi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbaProizvodi _$NarudzbaProizvodiFromJson(Map<String, dynamic> json) =>
    NarudzbaProizvodi(
      json['narudzbaProizvodiID'] as int?,
      json['proizvodID'] as int?,
      json['narudzbaID'] as int?,
      json['kolicina'] as int?,
      json['proizvod'] == null
          ? null
          : Proizvod.fromJson(json['proizvod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NarudzbaProizvodiToJson(NarudzbaProizvodi instance) =>
    <String, dynamic>{
      'narudzbaProizvodiID': instance.narudzbaProizvodiID,
      'proizvodID': instance.proizvodID,
      'narudzbaID': instance.narudzbaID,
      'kolicina': instance.kolicina,
      'proizvod': instance.proizvod,
    };

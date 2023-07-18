// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      json['brojNarudzbe'] as String?,
      json['datumNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumNarudzbe'] as String),
      (json['ukupnaCijena'] as num?)?.toDouble(),
    )
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..narudzbaProizvodi = json['narudzbaProizvodi'] as String?;

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'brojNarudzbe': instance.brojNarudzbe,
      'datumNarudzbe': instance.datumNarudzbe?.toIso8601String(),
      'ukupnaCijena': instance.ukupnaCijena,
      'korisnik': instance.korisnik,
      'narudzbaProizvodi': instance.narudzbaProizvodi,
    };

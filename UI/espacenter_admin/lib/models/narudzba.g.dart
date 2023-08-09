// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      json['narudzbaID'] as int?,
      json['brojNarudzbe'] as String?,
      json['datumNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumNarudzbe'] as String),
      (json['ukupnaCijena'] as num?)?.toDouble(),
      json['korisnikID'] as int?,
      json['isCanceled'] as bool?,
      json['isShipped'] as bool?,
      json['narudzbaProizvodi'] as String?,
      (json['narudzbaProizvodis'] as List<dynamic>?)
          ?.map((e) => NarudzbaProizvodi.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..korisnik = json['korisnik'] == null
        ? null
        : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'narudzbaID': instance.narudzbaID,
      'brojNarudzbe': instance.brojNarudzbe,
      'datumNarudzbe': instance.datumNarudzbe?.toIso8601String(),
      'ukupnaCijena': instance.ukupnaCijena,
      'korisnik': instance.korisnik,
      'korisnikID': instance.korisnikID,
      'isCanceled': instance.isCanceled,
      'isShipped': instance.isShipped,
      'narudzbaProizvodi': instance.narudzbaProizvodi,
      'narudzbaProizvodis': instance.narudzbaProizvodis,
    };

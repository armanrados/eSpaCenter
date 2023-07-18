// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['rezervacijaID'] as int?,
      json['terminID'] as int?,
      json['korisnikID'] as int?,
      json['terminVrijeme'] as String?,
      json['datumRezervacije'] == null
          ? null
          : DateTime.parse(json['datumRezervacije'] as String),
      json['terminRezervisao'] as String?,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      json['termin'] == null
          ? null
          : Termin.fromJson(json['termin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaID': instance.rezervacijaID,
      'korisnikID': instance.korisnikID,
      'terminID': instance.terminID,
      'datumRezervacije': instance.datumRezervacije?.toIso8601String(),
      'terminVrijeme': instance.terminVrijeme,
      'terminRezervisao': instance.terminRezervisao,
      'korisnik': instance.korisnik,
      'termin': instance.termin,
    };

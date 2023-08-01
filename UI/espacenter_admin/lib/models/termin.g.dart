// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      json['terminID'] as int?,
      json['korisnikID'] as int?,
      json['datumTermina'] == null
          ? null
          : DateTime.parse(json['datumTermina'] as String),
      json['vrijemeTermina'] as String?,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminID': instance.terminID,
      'korisnikID': instance.korisnikID,
      'datumTermina': instance.datumTermina?.toIso8601String(),
      'vrijemeTermina': instance.vrijemeTermina,
      'korisnik': instance.korisnik,
      'isVisible': instance.isVisible,
    };

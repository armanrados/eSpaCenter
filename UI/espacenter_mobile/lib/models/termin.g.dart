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
      json['isDeleted'] as bool?,
      json['isBooked'] as bool?,
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminID': instance.terminID,
      'korisnikID': instance.korisnikID,
      'datumTermina': instance.datumTermina?.toIso8601String(),
      'vrijemeTermina': instance.vrijemeTermina,
      'korisnik': instance.korisnik,
      'isBooked': instance.isBooked,
      'isDeleted': instance.isDeleted,
    };

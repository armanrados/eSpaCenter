import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'korisnik.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin {
  int? terminID;
  int? korisnikID;
  DateTime? datumTermina;
  String? vrijemeTermina;
  Korisnik? korisnik;
  bool? isDeleted;

  Termin(this.terminID, this.korisnikID, this.datumTermina, this.vrijemeTermina,
      this.korisnik, this.isDeleted);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TerminToJson(this);
}

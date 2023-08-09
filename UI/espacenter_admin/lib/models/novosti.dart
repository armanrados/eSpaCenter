import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
import 'korisnik.dart';
/// 
part 'novosti.g.dart';

@JsonSerializable()
class Novosti {
  int? novostiID;
  String? slika;
  String? naslov;
  String? sadrzaj;
  int? korisnikID;
  Korisnik? korisnik;
  DateTime? datumKreiranja;
  bool? isDeleted;

  Novosti(this.novostiID, this.slika, this.sadrzaj,this.naslov,this.korisnikID,this.korisnik,this.datumKreiranja, this.isDeleted );

    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Novosti.fromJson(Map<String, dynamic> json) => _$NovostiFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NovostiToJson(this);
}
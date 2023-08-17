
import 'package:json_annotation/json_annotation.dart';

import 'korisnik.dart';
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'galerija.g.dart';

@JsonSerializable()
class Galerija {
  int? galerijaID;
  String? slikaByte;
  String? opis;
  int? korisnikID;
  Korisnik? korisnik;
  bool? isDeleted;
  Galerija(this.galerijaID, this.slikaByte, this.opis,this.korisnikID,this.korisnik,this.isDeleted);

    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Galerija.fromJson(Map<String, dynamic> json) => _$GalerijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$GalerijaToJson(this);
}
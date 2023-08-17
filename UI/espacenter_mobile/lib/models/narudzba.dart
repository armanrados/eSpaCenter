
import 'package:json_annotation/json_annotation.dart';

import 'korisnik.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'narudzba.g.dart';

@JsonSerializable()
class Narudzba {
  int? narudzbaID;
  String? brojNarudzbe;
  DateTime? datumNarudzbe;
  double? ukupnaCijena;
  Korisnik? korisnik;
  int? korisnikID;
  bool? isCanceled;
  bool? isShipped;
  String? narudzbaProizvodi;
  Narudzba(this.narudzbaID,this.brojNarudzbe, this.datumNarudzbe, this.ukupnaCijena,this.korisnikID,this.isCanceled,this.isShipped,this.narudzbaProizvodi);

    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Narudzba.fromJson(Map<String, dynamic> json) => _$NarudzbaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NarudzbaToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'korisnik.dart';
import 'termin.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija {
  int? rezervacijaID;
  int? korisnikID;
  int? terminID;
  DateTime? datumRezervacije;
  String? terminVrijeme;
  String? terminRezervisao;
  Korisnik? korisnik;
  Termin? termin;
  bool? isCanceled;
  bool? isCompleted;
  bool? isDeleted;
  int? uslugaID;
  Rezervacija(
      this.rezervacijaID,
      this.terminID,
      this.korisnikID,
      this.terminVrijeme,
      this.datumRezervacije,
      this.terminRezervisao,
      this.korisnik,
      this.termin,
      this.isCanceled,
      this.isCompleted,
      this.uslugaID,
      this.isDeleted);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}

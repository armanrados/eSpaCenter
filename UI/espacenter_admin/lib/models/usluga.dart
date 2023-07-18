import 'package:json_annotation/json_annotation.dart';

part 'usluga.g.dart';

@JsonSerializable()
class Usluga{
  int? uslugaID;
  String? naziv;
  String? opis;

  Usluga(this.uslugaID,this.naziv,this.opis);


    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Usluga.fromJson(Map<String, dynamic> json) => _$UslugaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UslugaToJson(this);
}
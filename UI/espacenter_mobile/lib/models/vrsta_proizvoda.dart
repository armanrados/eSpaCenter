
import 'package:json_annotation/json_annotation.dart';

part 'vrsta_proizvoda.g.dart';


@JsonSerializable()
class VrstaProizvoda {
  int? vrstaProizvodaID;
  String? naziv;


  VrstaProizvoda(this.vrstaProizvodaID, this.naziv);

    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory VrstaProizvoda.fromJson(Map<String, dynamic> json) => _$VrstaProizvodaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$VrstaProizvodaToJson(this);
}
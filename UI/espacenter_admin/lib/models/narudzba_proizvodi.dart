import 'package:espacenter_admin/models/proizvod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'narudzba_proizvodi.g.dart';

@JsonSerializable()
class NarudzbaProizvodi{
  int? narudzbaProizvodiID;
  int? proizvodID;
  int? narudzbaID;
  int? kolicina;
  Proizvod? proizvod;

  NarudzbaProizvodi(this.narudzbaProizvodiID,this.proizvodID,this.narudzbaID,this.kolicina,this.proizvod);

  factory NarudzbaProizvodi.fromJson(Map<String, dynamic> json) => _$NarudzbaProizvodiFromJson(json);

    Map<String, dynamic> toJson() => _$NarudzbaProizvodiToJson(this);
}
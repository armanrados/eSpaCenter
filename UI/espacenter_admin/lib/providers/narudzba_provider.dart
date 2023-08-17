import 'package:espacenter_admin/models/narudzba.dart';


import 'base_provider.dart';

class NarudzbaProvider extends BaseProvider<Narudzba> {
    NarudzbaProvider(): super("Narudzba");

   @override
   Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }
}
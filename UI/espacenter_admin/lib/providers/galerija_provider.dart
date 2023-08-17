import 'package:espacenter_admin/models/galerija.dart';


import 'base_provider.dart';

class GalerijaProvider extends BaseProvider<Galerija> {
    GalerijaProvider(): super("Galerija");

   @override
   Galerija fromJson(data) {
    return Galerija.fromJson(data);
  }
}
import 'package:espacenter_admin/models/proizvod.dart';


import 'base_provider.dart';

class ProizvodProvider extends BaseProvider<Proizvod> {
  ProizvodProvider(): super("Proizvod");

   @override
  Proizvod fromJson(data) {
    return Proizvod.fromJson(data);
  }
}
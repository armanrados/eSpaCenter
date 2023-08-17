
import 'package:espacenter_admin/providers/base_provider.dart';


import '../models/vrsta_proizvoda.dart';

class VrstaProizvodaProvider extends BaseProvider<VrstaProizvoda> {
  VrstaProizvodaProvider(): super("VrstaProizvoda");

  @override
  VrstaProizvoda fromJson(data) {
    return VrstaProizvoda.fromJson(data);
  }


}
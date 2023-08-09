import 'package:espacenter_mobile/models/usluga.dart';
import 'package:espacenter_mobile/providers/base_provider.dart';


class UslugaProvider extends BaseProvider<Usluga> {
  UslugaProvider(): super("Usluga");

  @override
  Usluga fromJson(data) {
    return Usluga.fromJson(data);
  }


}
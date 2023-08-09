import 'package:espacenter_mobile/models/uplata.dart';
import 'package:espacenter_mobile/providers/base_provider.dart';


class UplataProvider extends BaseProvider<Uplata> {
  UplataProvider(): super("Uplata");

  @override
  Uplata fromJson(data) {
    return Uplata.fromJson(data);
  }


}
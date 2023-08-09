import 'package:espacenter_mobile/models/novosti.dart';
import 'base_provider.dart';

class NovostiProvider extends BaseProvider<Novosti> {
    NovostiProvider(): super("Novosti");

   @override
   Novosti fromJson(data) {
    return Novosti.fromJson(data);
  }
}
import 'package:espacenter_admin/models/novosti.dart';


import 'base_provider.dart';

class NovostProvider extends BaseProvider<Novosti> {
    NovostProvider(): super("Novosti");

   @override
   Novosti fromJson(data) {
    return Novosti.fromJson(data);
  }
}
import 'package:espacenter_mobile/models/recenzija.dart';
import 'base_provider.dart';

class RecenzijaProvider extends BaseProvider<Recenzija> {
    RecenzijaProvider(): super("Recenzija");

   @override
   Recenzija fromJson(data) {
    return Recenzija.fromJson(data);
  }
}
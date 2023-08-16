import 'package:espacenter_mobile/models/rezervacija.dart';
import 'base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija> {
    RezervacijaProvider(): super("Rezervacija");

   @override
   Rezervacija fromJson(data) {
    return Rezervacija.fromJson(data);
  }
  
}
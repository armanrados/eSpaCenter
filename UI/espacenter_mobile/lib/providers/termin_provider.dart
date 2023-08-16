import 'package:espacenter_mobile/models/termin.dart';
import 'base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider(): super("Termin");

   @override
  Termin fromJson(data) {
    
    return Termin.fromJson(data);
  }
  
}
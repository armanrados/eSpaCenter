import 'dart:convert';

import 'package:espacenter_mobile/models/proizvod.dart';
import 'package:http/http.dart' as http;
import '../utils/util.dart';
import 'base_provider.dart';

class ProizvodProvider extends BaseProvider<Proizvod> {
  ProizvodProvider(): super("Proizvod");

   @override
  Proizvod fromJson(data) {
    return Proizvod.fromJson(data);
  }
  Future<List<Proizvod>> Recommend() async{

    var uri = Uri.parse("$fullUrl/${Authorization.korisnik!.korisnikID}/recommended");

    Map<String , String> headers = createHeaders();

    var response = await http.get(uri , headers: headers);

    if(isValidResponse(response)){
      var data = jsonDecode(response.body);
      List<Proizvod> list = data.map((x) => fromJson(x)).cast<Proizvod>().toList(); 
      return list;
     }
     else{
      throw Exception("Error");
     }

  }
}
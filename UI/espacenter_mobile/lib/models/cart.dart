import 'package:espacenter_mobile/models/proizvod.dart';

class Cart {
    List<CartItem> items = [];
}

class CartItem {
  CartItem(this.proizvod,this.count);
  late Proizvod proizvod;
  late int count;
}
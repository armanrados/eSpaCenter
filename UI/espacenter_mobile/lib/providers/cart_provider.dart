import 'package:collection/collection.dart';
import 'package:espacenter_mobile/models/cart.dart';
import 'package:flutter/widgets.dart';

import '../models/proizvod.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();
  addToCart(Proizvod proizvod) {
    if (findInCart(proizvod) != null) {
      findInCart(proizvod)?.count++;
    } else {
      cart.items.add(CartItem(proizvod, 1));
    }
    
    notifyListeners();
  }

  removeFromCart(Proizvod proizvod) {
    cart.items.removeWhere((item) => item.proizvod.proizvodID == proizvod.proizvodID);
    notifyListeners();
  }

  CartItem? findInCart(Proizvod proizvod) {
    CartItem? item = cart.items.firstWhereOrNull((item) => item.proizvod.proizvodID == proizvod.proizvodID);
    return item;
  }
}
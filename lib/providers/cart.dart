import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;

    _cartItems.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(String? productId, double price, String title) {
    if (cartItems.containsKey(productId)) {
      _cartItems.update(
        productId!,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: title,
            price: price,
            quantity: existingCartItem.quantity + 1),
      );
    } else {
      _cartItems.putIfAbsent(
        productId!,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }

  void removeSingleItem(String? productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
          productId!,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }
}

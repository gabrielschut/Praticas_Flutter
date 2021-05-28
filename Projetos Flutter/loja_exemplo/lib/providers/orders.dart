import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:loja_exemplo/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.products,
    this.total,
    this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemCount{
    return _items.length;
  }

  void addOrder(Cart cart) {
    //primeira implementação feita usando o fold
    // final combine = (t, i) => t + (i.price * i.quantity);
    // final total = products.fold(0, combine);
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          date: DateTime.now(),
          products: cart.items.values.toList(),
        ),
    );
    notifyListeners();
  }
}

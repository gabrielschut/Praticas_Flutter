import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loja_exemplo/providers/cart.dart';
import 'package:loja_exemplo/utils/cosntants.dart';

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
  String _baseUrl = '${Constants.BASE_API_URL}/orders';
  String _token;
  String _userId;

  Orders([this._token, this._items = const [], this._userId]);

  List<Order> get items {
    return [..._items];
  }

  int get itemCount{
    return _items.length;
  }

  Future<void> loadOrders() async{

    List<Order> loadedItens = [];
    final response = await http.get("$_baseUrl/$_userId.json?auth=$_token");
    Map<String , dynamic> data = jsonDecode((response.body));
    if(data != null){
      data.forEach((orderId, orderData) {
        loadedItens.add(Order(
          id: orderId,
          total: orderData['total'],
          date: DateTime.parse(orderData['date']),
          products: (orderData['products'] as List<dynamic>).map((item){
            return CartItem(
                id: item['id'],
                productId: item['id'],
                title: item['title'],
                price: item['price'],
                quantity: item['quantity']
            );
          }).toList(),
        ),
        );
        _items = loadedItens.reversed.toList();
      });
      notifyListeners();
    }

    return Future.value();
  }


  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    DateFormat.YEAR_MONTH_DAY;
    final response = await http.post(
      "$_baseUrl/$_userId.json?auth=$_token",
      body: jsonEncode({
        'total' : cart.totalAmount,
        'date' : date.toIso8601String(),
        'products' : cart.items.values.map((cartItem) => {
          'id' : cartItem.id,
          'productId' : cartItem.productId,
          'title': cartItem.title,
          'quantity': cartItem.quantity,
          'price': cartItem.price,
      }).toList()
      })
    );

    _items.insert(
        0,
        Order(
          id: jsonDecode(response.body)['name'],
          total: cart.totalAmount,
          date: date,
          products: cart.items.values.toList(),
        ),
    );
    notifyListeners();
  }
}

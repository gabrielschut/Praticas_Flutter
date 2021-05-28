
import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/product.dart';
import 'package:loja_exemplo/data/dummy_data.dart';

class Products with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems{
   return items.where((prod) => prod.isFavorite).toList();
  }


  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }
}

// refs aula 220
//
// bool  _showFavoriteOnly = false;
// void showFavoriteOnly(){
//   _showFavoriteOnly =true;
//   notifyListeners();
// }
//
// void showAll(){
//   _showFavoriteOnly =false;
//   notifyListeners();
// }
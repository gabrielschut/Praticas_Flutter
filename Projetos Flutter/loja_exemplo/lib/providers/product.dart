
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_exemplo/data/dummy_data.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite,
  });

  void toggleFavorite(){
    this.isFavorite = !isFavorite;
    notifyListeners();
  }

}

class Products with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems{
   return items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product newProduct){
    _items.add(Product(
      id: Random().nextDouble().toString(),
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  void updateProduct(Product product){
    if(product.id == null || product == null){
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if(index >=0 ){
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id){
    final index = _items.indexWhere((prod) => prod.id == id);
    if(index >= 0){
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }

  int get itemsCount{
    return _items.length;
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_exemplo/utils/cosntants.dart';

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
    this.isFavorite = false,
  });

  void _toggleFavorite(){
    this.isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async{
    _toggleFavorite();
    try{
      final url ='${Constants.BASE_API_URL}/products';
      final response = await http.patch(
          url,
          body: json.encode({
            'IsFavorite' : isFavorite = !this.isFavorite,
          })
      );

      if(response.statusCode >= 400){
        _toggleFavorite();
      }
    }catch(error){
      _toggleFavorite();
    }



  }

}

class Products with ChangeNotifier{
  final _baseUrl = '${Constants.BASE_API_URL}/products';
  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems{
   return items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) async{
    final response = await
    http.post("$_baseUrl.json",
    body: json.encode({
      'title' : newProduct.title,
      'price' : newProduct.price,
      'description' : newProduct.description,
      'imageUrl' : newProduct.imageUrl,
      'isFavorite' : newProduct.isFavorite = false,
    }),
    );
        _items.add(Product(
          id: json.decode(response.body)['name'],
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl,
          isFavorite: newProduct.isFavorite,
        ));
        notifyListeners();
  }

  Future<void> loadProducts() async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data= json.decode(response.body);

    _items.clear();

    data.forEach((productId, productData) {
      if(data != null){
        _items.add(Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite']
        ));
        notifyListeners();
      }
      return Future.value();
      });


  }

  Future<void> updateProduct(Product product) async{
    if(product.id == null || product == null){
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if(index >=0 ){
      await http.patch("$_baseUrl/${product.id}.json",
      body: jsonEncode({
        'title' : product.title,
        'price' : product.price,
        'description' : product.description,
        'imageUrl' : product.imageUrl,
      }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if(index >= 0){
      final product = _items[index];

      final response = await http.delete("$_baseUrl/${product.id}.json");

      if(response.statusCode > 400){
        _items.insert(index, product);
        notifyListeners();
      }else{
        _items.remove(product);
        notifyListeners();
      }
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
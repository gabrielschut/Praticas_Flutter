import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/product.dart';
import 'package:provider/provider.dart';

import 'package:loja_exemplo/providers/cart.dart';

import 'package:loja_exemplo/utils/app_routes.dart';

import 'package:loja_exemplo/widgets/app_drawer.dart';
import 'package:loja_exemplo/widgets/product_grid.dart';
import 'package:loja_exemplo/widgets/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProdutsOverviewScrenn extends StatefulWidget {
  ProdutsOverviewScrenn();

  @override
  _ProdutsOverviweScrennState createState() => _ProdutsOverviweScrennState();
}

class _ProdutsOverviweScrennState extends State<ProdutsOverviewScrenn> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    //carrega produtos do firebase
    Provider.of<Products>(context , listen: false).loadProducts()
        .then((_) {
          setState(() {
            _isLoading = false;
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          '     Minha loja',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          PopupMenuButton(
            elevation: 100,
            color: Colors.blue[400],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) =>
            [
              PopupMenuItem(
                child: Text(
                  'Somente favoritos',
                  style: TextStyle(
                    color: Colors.white,
                  ) ,
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                    'Todos',
                  style: TextStyle(
                    color: Colors.white,
                  ) ,
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.Cart);
              },
            ),
            builder: (_, cart, child) =>
                Badge(
                  value: cart.itemsCount.toString(),
                  cor: Theme
                      .of(context)
                      .accentColor,
                  child: child,
                ),
          ),
        ],
      ),
      body: _isLoading ? Container(
        margin: EdgeInsets.all(50),
        child: Center(
          child: LinearProgressIndicator(
            color: Colors.blueAccent,
          ),
        ),
      )
          : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer()
      ,
    );
  }
}

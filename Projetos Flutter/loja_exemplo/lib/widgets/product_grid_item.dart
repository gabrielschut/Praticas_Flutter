
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';
import 'package:loja_exemplo/providers/product.dart';

class ProductGridItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: SizedBox.fromSize(
            size: Size(25,55),
            child: Consumer<Product>(
              builder: (ctx, product,_){
                return IconButton(
                icon: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_sharp ),
                color: Colors.redAccent,
                onPressed: () {
                  product.toggleFavorite();
                },
              );
              }),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart,
            size: 15,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado com sucesso!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.blue[200],
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.pink,
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}





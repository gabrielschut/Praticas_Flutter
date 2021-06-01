
import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/product.dart';
import 'package:loja_exemplo/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:loja_exemplo/providers/cart.dart';


class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context , listen: false);
    final Cart cart = Provider.of<Cart>(context , listen: false);

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
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_sharp),
              onPressed: () => product.toggleFavorite(),
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product);
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
            },
          ),
        ),
      ),
    );
  }
}
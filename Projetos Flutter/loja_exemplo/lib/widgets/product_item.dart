import 'package:flutter/material.dart';

import 'package:loja_exemplo/providers/product.dart';
import 'package:loja_exemplo/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTFORM,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme
                  .of(context)
                  .errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) =>
                      AlertDialog(
                        title: Text('Excluir produto'),
                        content: Text('Deseja excluir o produto'),
                        actions: [
                          TextButton(
                              child: Text('SIM'),
                              onPressed: () => Navigator.of(context).pop(true),
                              ),
                          TextButton(child: Text('NÂO'),
                              onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                ).then((value) {
                  if (value) {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(product.id);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

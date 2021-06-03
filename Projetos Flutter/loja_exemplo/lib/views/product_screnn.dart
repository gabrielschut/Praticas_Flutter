import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/product.dart';
import 'package:loja_exemplo/utils/app_routes.dart';
import 'package:loja_exemplo/widgets/app_drawer.dart';
import 'package:loja_exemplo/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductScenn extends StatelessWidget {

  Future<void> _refreshProduct(BuildContext context) async {
    Provider.of<Products>(context, listen: false ).loadProducts();
  }


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            'Gerênciamento de Produtos',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTFORM);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.itemsCount,
            itemBuilder: (context, i) => Column(
              children: [
                ProductItem(products[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

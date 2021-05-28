import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/product.dart';

class ProductDetailScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final Product product = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('R\$ ${product.price}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: Text(product.description,
              textAlign: TextAlign.center,
              ),

            )
          ],
        ),
      ),
    );
  }


}

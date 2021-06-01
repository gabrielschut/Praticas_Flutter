import 'package:flutter/material.dart';

import 'package:loja_exemplo/providers/orders.dart';
import 'package:loja_exemplo/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:loja_exemplo/widgets/order_widget.dart';

class OrdersScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemCount,
        itemBuilder: (context, i) => OrderWidget(orders.items[i]),

      ),
    );
  }
}

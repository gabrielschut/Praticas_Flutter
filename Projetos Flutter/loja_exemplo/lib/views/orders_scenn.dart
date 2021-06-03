import 'package:flutter/material.dart';

import 'package:loja_exemplo/providers/orders.dart';
import 'package:loja_exemplo/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:loja_exemplo/widgets/order_widget.dart';

class OrdersScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: LinearProgressIndicator(),
                ));
          } else {
            return Consumer<Orders>(
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.itemCount,
                itemBuilder: (context, i) => OrderWidget(orders.items[i]),
              ),
            );
          }
        },
      ),
      // _isLoading
      //     ? Center(
      //         child: LinearProgressIndicator(),
      //       )
      //     : RefreshIndicator(
      //   onRefresh: ()=> _refreshOrders(context),
      //       child: ListView.builder(
      //           itemCount: orders.itemCount,
      //           itemBuilder: (context, i) => OrderWidget(orders.items[i]),
      //         ),
      //     ),
    );
  }
}

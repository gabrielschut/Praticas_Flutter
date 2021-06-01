import 'package:flutter/material.dart';

import 'package:loja_exemplo/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text('Bem vindo'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Loja'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment,
            color: Theme.of(context).primaryColor,
            ),
            title: Text('Padidos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.ORDERS);
            },
          ),
          Divider(),
          ListTile(
             leading: Icon(Icons.edit,
               color: Theme.of(context).primaryColor,
             ),
             title: Text('Gerenciar Produtos'),
             onTap: () {
               Navigator.pushReplacementNamed(context, AppRoutes.PRODUCTS);
               },
          ),
          Divider(),
        ],
      ),
    );
  }
}

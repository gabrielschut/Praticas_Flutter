import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/auth.dart';

import 'package:loja_exemplo/utils/app_routes.dart';
import 'package:provider/provider.dart';

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
              Navigator.pushReplacementNamed(context, AppRoutes.PRODUCT_OVERVIEW);
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
          ListTile(
            leading: Icon(Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}

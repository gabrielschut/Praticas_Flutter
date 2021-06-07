import 'package:flutter/material.dart';

import 'package:loja_exemplo/providers/auth.dart';
import 'package:loja_exemplo/providers/cart.dart';
import 'package:loja_exemplo/providers/orders.dart';
import 'package:loja_exemplo/providers/product.dart';

import 'package:loja_exemplo/utils/app_routes.dart';

import 'package:loja_exemplo/views/auth_home_screnn.dart';
import 'package:loja_exemplo/views/auth_screnn.dart';
import 'package:loja_exemplo/views/cart_screnn.dart';
import 'package:loja_exemplo/views/orders_scenn.dart';
import 'package:loja_exemplo/views/product_detail_screnn.dart';
import 'package:loja_exemplo/views/product_form_screnn.dart';
import 'package:loja_exemplo/views/product_screnn.dart';
import 'package:loja_exemplo/views/products_overview_screen.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts.items,
            auth.userId,
          ),
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders.items,
            auth.userId,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: AuthOrHomeScrenn(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScrenn(),
          AppRoutes.Cart: (ctx) => CartScrenn(),
          AppRoutes.ORDERS: (ctx) => OrdersScrenn(),
          AppRoutes.PRODUCTS: (ctx) => ProductScenn(),
          AppRoutes.PRODUCTFORM: (ctx) => ProductFormScreen(),
          AppRoutes.PRODUCT_OVERVIEW: (ctx) => ProdutsOverviewScrenn(),
          AppRoutes.AUTHSCRENN: (ctx) => AuthScrenn(),
        },
      ),
    );
  }
}

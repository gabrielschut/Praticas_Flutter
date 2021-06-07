import 'package:flutter/material.dart';
import 'package:loja_exemplo/providers/auth.dart';
import 'package:loja_exemplo/views/auth_screnn.dart';
import 'package:loja_exemplo/views/products_overview_screen.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
        builder: (ctx, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.error != null){
            return Center(
              child: Text("Ocorreu um erro"),
            );
          }else{
            return auth.isAuth? ProdutsOverviewScrenn() : AuthScrenn();
          }
        }
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:loja_exemplo/widgets/auth_card.dart';

class AuthScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(27, 92, 160, 0.5),
                  Color.fromRGBO(9, 13, 138, 0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 110
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 5,
                      left: 10
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 70,
                    ),
                    transform: Matrix4.rotationZ(-4 * pi /180)..translate(-10.0),
                    // .. é o operador de cascata, ele devolve o tipo do seu anterior.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54,
                      boxShadow:[
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black54,
                          offset: Offset(5,8)
                        )
                      ]
                    ),
                    child: Text(
                      'Minha Loja',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 35,
                        fontFamily: 'Anton'
                      ),
                    ),
                  ),
                  AuthCard(),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

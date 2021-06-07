import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_exemplo/data/store.dart';
import 'package:loja_exemplo/exceptions/firebase_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer logoutTimer;
  Store store;

  bool get isAuth{
    return token != null;
  }

  String get userId{
    return isAuth
        ? _userId
        : null;
  }

  String get token{
    if(_token != null && _expiryDate != null
        && _expiryDate.isAfter(DateTime.now())){
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, String urlSegment)async{
   String url = urlSegment+' ';
   //coloque a chave da sua apliação firebase no espaço vazio
     final response = await  http.post(
         url,
         body:jsonEncode({
           'email' : email,
           'password': password,
           'returnSecureToken' : true,
         })
     );
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if(responseBody["error"] != null){
        throw AuthException(responseBody['error']['message']);
      }else{
        _token = responseBody["idToken"];
        _userId = responseBody["localId"];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(responseBody["expiresIn"]),
          ),
        );

        store.saveMap('userData', {
          "token" : _token,
          "userId" : _userId,
          "expiryDate": _expiryDate.toIso8601String(),
        });

        _autoLogout();
        notifyListeners();
      }

     return Future.value();
  }

  Future<void> signup(String email, String password) async {
      return _authenticate(email, password, "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=");
  }

  Future<void> tryAutoLogin() async {
    if(isAuth){
      return Future.value();
    }
    final userData = await store.getMap('userData');
    if(userData == null){
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData["expiryDate"]);
    if(expiryDate.isBefore(DateTime.now())){
      return Future.value();
    }
    _userId = userData["userId"];
    _token = userData["token"];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
    return Future.value();

  }

  void logout(){
    _token =null;
    _userId = null;
    _expiryDate =null;
    if(logoutTimer != null) {
      logoutTimer.cancel();
      logoutTimer = null;
    }
    Store.remove('userData');
    notifyListeners();
  }

  void _autoLogout(){
    if(logoutTimer != null){
      logoutTimer.cancel();
    }
    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    logoutTimer =Timer(Duration(seconds: timeToLogout),logout);
  }

}
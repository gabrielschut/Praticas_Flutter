import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    saveString(key, jsonEncode(value));
  }

  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
   return prefs.getString(key);
  }

  Future<Map<String, dynamic>> getMap(String key) async {
    try{
      Map<String, dynamic> map = jsonDecode(await getString(key));
      return map;
    }catch(_){
      return null;
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
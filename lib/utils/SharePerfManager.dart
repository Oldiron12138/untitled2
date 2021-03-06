import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePerfManager{
  static cleanSharep() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static saveSharePref<T>(String key, T value) async {
    print("zwj save string111 ${value.runtimeType}");
   // SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(value.runtimeType) {
      case String:
        print("zwj save string");
        prefs.setString(key, value.toString());
        break;
      case bool:
        bool va = value as bool;
        prefs.setBool(key, va);
        break;
      case int:
        int va = value as int;
        prefs.setInt(key, va);
        break;
    }
  }

  static saveSharePrefList(String key, List<String> value) async {
    print("zwj save string111 ${value.runtimeType}");
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  static Future<List<String>> getSharePrefList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = await prefs.getStringList(key);
    return userName;
  }

  static Future<int> getSharePrefCoin(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = await prefs.getInt(key);
    return userName;
  }

  static Future<String> getSharePref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = await prefs.getString(key);
    return userName;
  }

  static Future<bool> getSharePrefBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userName = await prefs.getBool(key);
    return userName;
  }

}


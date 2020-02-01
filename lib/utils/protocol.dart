import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Protocol with ChangeNotifier {
  bool _pass = false;

  static const String PASS = "passProtocol";

  Protocol() {
    _initState();
  }

  get pass => _pass;

  void _initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _pass = prefs.getBool(PASS) ?? false;

    notifyListeners();
  }

  void setPass(bool pass) async {
    _pass = pass;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PASS, _pass);
  }
}

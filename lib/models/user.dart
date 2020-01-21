import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String _id;
  String _name;
  String _joinDate;

  static const String ID = "user.id";
  static const String NAME = "user.name";
  static const String JOINDATE = "user.joinDate";

  User() {
    _initState();
  }

  get id => _id;
  get name => _name;
  get joinDate => _joinDate;
  get isOnline => (_id != null);

  void logIn(String id, String name, String joinDate) async {
    _id = id;
    _name = name;
    _joinDate = joinDate;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ID, _id);
    prefs.setString(NAME, _name);
    prefs.setString(JOINDATE, _joinDate);
  }

  void logOut() async {
    _id = null;
    _name = null;
    _joinDate = null;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(ID);
    prefs.remove(NAME);
    prefs.remove(JOINDATE);
  }

  void _initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _id = prefs.getString(ID);
    _name = prefs.getString(NAME);
    _joinDate = prefs.getString(JOINDATE);

    notifyListeners();
  }
}

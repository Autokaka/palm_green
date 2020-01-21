import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/url_ref.dart';
import 'package:provider/provider.dart';

class LoginHandler {
  final BuildContext _context;

  LoginHandler(this._context);

  String validateId(String value) {
    value = value.trim();
    String request =
        FlutterI18n.translate(_context, "utils.login_handler.validate_id");
    RegExp regExp = RegExp(r"^[0-9]*$");
    if (regExp.stringMatch(value) == value) request = null;
    return request;
  }

  String validatePass(String value) {
    value = value.trim();
    String request =
        FlutterI18n.translate(_context, "utils.login_handler.validate_pass");
    RegExp regExp =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]{8,20}$");
    if (regExp.stringMatch(value) == value) request = null;
    return request;
  }

  void login(
    GlobalKey formKey,
    String id,
    String password,
  ) async {
    if (!(formKey.currentState as FormState).validate()) return;

    var formData = {
      "id": id,
      "password": password,
    };

    try {
      Response response = await Dio().post(
        UrlRef.login,
        data: formData,
      );

      dynamic resData = json.decode(response.data);
      if (resData is bool && !resData) {
        final snackBar = SnackBar(
          content: Text(FlutterI18n.translate(
              _context, "utils.login_handler.login_fail")),
        );
        Scaffold.of(_context).showSnackBar(snackBar);
      } else {
        Provider.of<User>(_context, listen: false)
            .logIn(resData["id"], resData["name"], resData["join_date"]);
        Navigator.pop(_context);
      }
    } catch (e) {
      print(e);
    }
  }

  void register(
    GlobalKey formKey,
    String id,
    String password,
  ) async {
    if (!(formKey.currentState as FormState).validate()) return;

    var formData = {
      "id": id,
      "password": password,
    };

    try {
      Response response = await Dio().post(
        UrlRef.register,
        data: formData,
      );
      dynamic resData = json.decode(response.data);

      if (resData is bool && !resData) {
        final snackBar = SnackBar(
          content: Text(FlutterI18n.translate(
              _context, "utils.login_handler.register_fail")),
        );
        Scaffold.of(_context).showSnackBar(snackBar);
      } else {
        Provider.of<User>(_context, listen: false).logIn(
          id,
          FlutterI18n.translate(_context, "utils.login_handler.name_validate"),
          FlutterI18n.translate(
              _context, "utils.login_handler.join_date_validate"),
        );
        Navigator.pop(_context);
      }
    } catch (e) {
      print(e);
    }
  }
}

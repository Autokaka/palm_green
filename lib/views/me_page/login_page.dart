import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/login_handler.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  LoginHandler _loginHandler;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.login_page.title")),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _loginHandler = LoginHandler(context);
          return Form(
            key: _formKey,
            autovalidate: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText:
                          FlutterI18n.translate(context, "views.login_page.id"),
                      hintText: FlutterI18n.translate(
                          context, "views.login_page.id_hint"),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => _loginHandler.validateId(value),
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(
                          context, "views.login_page.password"),
                      hintText: FlutterI18n.translate(
                          context, "views.login_page.password_hint"),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) => _loginHandler.validatePass(value),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton.icon(
                        icon: Icon(CommunityMaterialIcons.login),
                        label: Text(
                          FlutterI18n.translate(
                              context, "views.login_page.confirm"),
                        ),
                        textTheme: ButtonTextTheme.primary,
                        onPressed: () => _loginHandler.login(
                          _formKey,
                          _idController.text,
                          _passController.text,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      FlatButton.icon(
                        icon: Icon(CommunityMaterialIcons.registered_trademark),
                        label: Text(
                          FlutterI18n.translate(
                              context, "views.login_page.register"),
                        ),
                        onPressed: () => _loginHandler.register(
                          _formKey,
                          _idController.text,
                          _passController.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

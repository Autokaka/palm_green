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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _registerMode = false;
  LoginHandler _loginHandler;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                  // 账户
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText:
                          FlutterI18n.translate(context, "views.login_page.id"),
                      hintText: FlutterI18n.translate(
                          context, "views.login_page.id_hint"),
                      prefixIcon: Icon(CommunityMaterialIcons.star),
                    ),
                    validator: (value) => _loginHandler.validateId(value),
                  ),
                  // 姓名
                  _registerMode
                      ? TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: FlutterI18n.translate(
                                context, "views.login_page.name"),
                            hintText: FlutterI18n.translate(
                                context, "views.login_page.name_hint"),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) =>
                              _loginHandler.validateName(value),
                        )
                      : Container(),
                  // 密码
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
                      // 登录按钮
                      _registerMode
                          ? Container()
                          : FlatButton.icon(
                              color: Theme.of(context).primaryColor,
                              colorBrightness: Brightness.dark,
                              icon: Icon(CommunityMaterialIcons.login),
                              label: Text(
                                FlutterI18n.translate(
                                    context, "views.login_page.confirm"),
                              ),
                              onPressed: () => _loginHandler.login(
                                _formKey,
                                _idController.text,
                                _passController.text,
                              ),
                            ),
                      // 注册按钮
                      Padding(padding: EdgeInsets.all(10)),
                      FlatButton.icon(
                        icon: Icon(CommunityMaterialIcons.registered_trademark),
                        color: _registerMode
                            ? Theme.of(context).primaryColor
                            : null,
                        colorBrightness: _registerMode ? Brightness.dark : null,
                        label: Text(
                          _registerMode
                              ? FlutterI18n.translate(
                                  context, "views.login_page.confirm_register")
                              : FlutterI18n.translate(
                                  context, "views.login_page.register"),
                        ),
                        onPressed: _onRegisterClick,
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

  void _onRegisterClick() {
    if (!_registerMode) {
      setState(() {
        _registerMode = true;
      });
    } else {
      _loginHandler.register(
        _formKey,
        _idController.text,
        _nameController.text,
        _passController.text,
      );
    }
  }
}

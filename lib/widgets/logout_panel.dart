import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/user.dart';
import 'package:provider/provider.dart';

class LogoutPanel extends StatefulWidget {
  @override
  _LogoutPanelState createState() => _LogoutPanelState();
}

class _LogoutPanelState extends State<LogoutPanel> {
  @override
  Widget build(BuildContext context) {
    if (!Provider.of<User>(context).isOnline) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 30, left: 5, right: 5),
        child: RaisedButton.icon(
          icon: Icon(Icons.send),
          label: Text(
              FlutterI18n.translate(context, "views.settings_page.logout")),
          textTheme: ButtonTextTheme.primary,
          color: Colors.red,
          onPressed: _logOut,
        ),
      );
    }
  }

  void _logOut() {
    Provider.of<User>(context, listen: false).logOut();
    Navigator.pop(context);
  }
}

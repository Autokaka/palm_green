import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/me_page/login_page.dart';

class MeOffline extends StatefulWidget {
  @override
  _MeOfflineState createState() => _MeOfflineState();
}

class _MeOfflineState extends State<MeOffline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
      child: FlatButton.icon(
        icon: Icon(Icons.send),
        label: Text(FlutterI18n.translate(context, "widgets.me_offline.label")),
        colorBrightness: Brightness.dark,
        color: Theme.of(context).primaryColor,
        onPressed: () => QuickLauncher.go(context, LoginPage()),
      ),
    );
  }
}

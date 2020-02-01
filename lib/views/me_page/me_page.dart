import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/widgets/app_info.dart';
import 'package:palm_green/widgets/easy_list.dart';
import 'package:palm_green/widgets/me_offline.dart';
import 'package:palm_green/widgets/me_online.dart';
import 'package:provider/provider.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(FlutterI18n.translate(context, "views.me_page.title")),
      ),
      body: EasyList(
        children: <Widget>[
          Provider.of<User>(context).isOnline ? MeOnline() : MeOffline(),
          AppInfo(),
        ],
      ),
    );
  }
}

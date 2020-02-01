import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/im_page/im_page.dart';
import 'package:palm_green/widgets/easy_list.dart';

class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(FlutterI18n.translate(context, "views.msg_page.title")),
      ),
      body: EasyList(
        children: <Widget>[
          ListTile(
            leading: Icon(CommunityMaterialIcons.leaf),
            title: Text("绿荫妙妙屋"),
            onTap: () => QuickLauncher.go(context, IMPage()),
          ),
        ],
      ),
    );
  }
}

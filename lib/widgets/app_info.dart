import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/version_manager.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/settings_page/settings_page.dart';
import 'package:provider/provider.dart';

class AppInfo extends StatefulWidget {
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(CommunityMaterialIcons.settings_box),
            title: Text(
                FlutterI18n.translate(context, "widgets.app_info.settings")),
            onTap: () => QuickLauncher.go(context, SettingsPage()),
          ),
          ListTile(
            leading: Icon(CommunityMaterialIcons.cloud),
            title: Text(
                FlutterI18n.translate(context, "widgets.app_info.version")),
            subtitle: Text(Provider.of<VersionManager>(context).version),
            onTap: () => Provider.of<VersionManager>(context, listen: false)
                .checkUpdate(context),
          ),
          ListTile(
            leading: Icon(CommunityMaterialIcons.human_greeting),
            title: Text(
                FlutterI18n.translate(context, "widgets.app_info.maintainer")),
            subtitle: Text("Autokaka, Njtech University"),
            onTap: () => {},
          ),
          ListTile(
            isThreeLine: true,
            leading: Icon(CommunityMaterialIcons.alert_circle),
            title: Text(FlutterI18n.translate(
                context, "widgets.app_info.announcement")),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 2.5, bottom: 15),
              child: Text(
                  "本软件由南京工业大学绿荫工作室制作和维护, 采用后台注册方式, 仅用于绿荫工作室内部成员技术交流使用, 请于24小时内自觉卸载本软件, 谢谢配合"),
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

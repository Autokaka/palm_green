import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/settings_page/theme_page.dart';
import 'package:palm_green/widgets/easy_list.dart';
import 'package:palm_green/widgets/logout_panel.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text(FlutterI18n.translate(context, "views.settings_page.title")),
      ),
      body: EasyList(
        children: <Widget>[
          // 主题颜色
          ListTile(
            title: Text(FlutterI18n.translate(
                context, "views.settings_page.theme_color")),
            leading: Icon(CommunityMaterialIcons.format_paint),
            onTap: () => QuickLauncher.go(context, ThemePage()),
          ),
          // 下线
          LogoutPanel(),
        ],
      ),
    );
  }
}

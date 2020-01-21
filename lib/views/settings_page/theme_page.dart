import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/theme_color.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.theme_page.title")),
      ),
      body: Column(
        children: <Widget>[
          // 夜间模式跟随系统
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.follow_dark"),
              style: TextStyle(
                color: Provider.of<ThemeColor>(context).primarySwatchColor,
              ),
            ),
            leading: Icon(
              CommunityMaterialIcons.light_switch,
              color: Provider.of<ThemeColor>(context).primarySwatchColor,
            ),
            trailing: Switch.adaptive(
              value: Provider.of<ThemeColor>(context).followSystem,
              onChanged: (value) => Provider.of<ThemeColor>(
                context,
                listen: false,
              ).setFollowSystem(value),
            ),
          ),
          // 知乎蓝
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.blue"),
              style: TextStyle(color: Colors.blue),
            ),
            leading: Icon(
              CommunityMaterialIcons.circle,
              color: Colors.blue,
            ),
            onTap: () => Provider.of<ThemeColor>(context, listen: false)
                .setThemeColor(Colors.blue, Brightness.light),
          ),
          // 贤者之蓝
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.indigo"),
              style: TextStyle(color: Colors.blue),
            ),
            leading: Icon(
              CommunityMaterialIcons.circle,
              color: Colors.indigo,
            ),
            onTap: () => Provider.of<ThemeColor>(context, listen: false)
                .setThemeColor(Colors.indigo, Brightness.light),
          ),
          // 水鸭青
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.teal"),
              style: TextStyle(color: Colors.teal),
            ),
            leading: Icon(
              CommunityMaterialIcons.circle,
              color: Colors.teal,
            ),
            onTap: () => Provider.of<ThemeColor>(context, listen: false)
                .setThemeColor(Colors.teal, Brightness.light),
          ),
          // 酷安绿
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.green"),
              style: TextStyle(color: Colors.green),
            ),
            leading: Icon(
              CommunityMaterialIcons.circle,
              color: Colors.green,
            ),
            onTap: () => Provider.of<ThemeColor>(context, listen: false)
                .setThemeColor(Colors.green, Brightness.light),
          ),
          // Bili粉
          ListTile(
            title: Text(
              FlutterI18n.translate(context, "views.theme_page.pink"),
              style: TextStyle(color: Colors.pink),
            ),
            leading: Icon(
              CommunityMaterialIcons.circle,
              color: Colors.pink,
            ),
            onTap: () => Provider.of<ThemeColor>(context, listen: false)
                .setThemeColor(Colors.pink, Brightness.light),
          ),
          // 夜间模式
          Provider.of<ThemeColor>(context).followSystem
              ? Container()
              : ListTile(
                  title: Text(
                    FlutterI18n.translate(context, "views.theme_page.dark"),
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    CommunityMaterialIcons.circle,
                    color: Colors.black,
                  ),
                  onTap: () => Provider.of<ThemeColor>(context, listen: false)
                      .setBrightness(Brightness.dark),
                ),
        ],
      ),
    );
  }
}

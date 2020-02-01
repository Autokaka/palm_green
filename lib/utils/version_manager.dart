import 'dart:async';
import 'dart:convert';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_info/package_info.dart';
import 'package:palm_green/url_ref.dart';
import 'package:palm_green/utils/dialogger.dart';
import 'package:palm_green/widgets/dio_button.dart';
import 'package:palm_green/widgets/easy_list.dart';

class VersionManager with ChangeNotifier {
  String _version = "";
  String _display = "";
  BuildContext _context;

  VersionManager() {
    _initState();
  }

  get display => _display;

  void _initState() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _display = _version;
  }

  void checkUpdate(BuildContext context) async {
    _context = context;
    _display = FlutterI18n.translate(context, "utils.version_manager.checking");
    notifyListeners();

    Response response = await Dio().post(UrlRef.checkUpdate, data: _version);
    var result = json.decode(response.data);
    if (result is bool && !result) {
      _display =
          FlutterI18n.translate(_context, "utils.version_manager.is_latest");
      notifyListeners();
      Timer(Duration(seconds: 2), () {
        _display = _version;
        notifyListeners();
      });
    } else {
      _display = "● " +
          FlutterI18n.translate(_context, "utils.version_manager.exist_latest");
      notifyListeners();

      String url = result["latest"];
      String changelog = result["changelog"];

      Dialogger.showBottom(
        context: _context,
        child: EasyList(
          children: <Widget>[
            ListTile(
              title: Text(
                "●   ${FlutterI18n.translate(context, "utils.version_manager.exist_latest")}",
                style: TextStyle(color: Colors.green),
              ),
              trailing: DioButton(
                icon: Icon(CommunityMaterialIcons.update),
                label: Text(FlutterI18n.translate(
                    context, "utils.version_manager.update")),
                url: url,
              ),
            ),
            MarkdownBody(data: changelog),
          ],
        ),
      );
    }
  }
}

import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info/package_info.dart';
import 'package:palm_green/models/theme_color.dart';
import 'package:palm_green/utils/paths.dart';
import 'package:provider/provider.dart';

class DioButton extends StatefulWidget {
  final Widget icon;
  final Widget label;
  final String url;

  DioButton({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.url,
  }) : super(key: key);

  @override
  _DioButtonState createState() => _DioButtonState();
}

class _DioButtonState extends State<DioButton> {
  double _value = 0;
  Widget _icon;
  Widget _label;
  Dio _dio = Dio();
  String _downPath;
  String _appId;

  // 下载状态标记
  // bool _stopped = false;
  // bool _cancelled = false;

  @override
  void initState() {
    super.initState();
    _icon ??= widget.icon;
    _label ??= widget.label;
  }

  @override
  Widget build(BuildContext context) {
    _buildNeeds();
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            height: 35,
            width: 87,
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(
                  Provider.of<ThemeColor>(context).primarySwatchColor),
              value: _value,
            ),
          ),
        ),
        Positioned(
          child: OutlineButton.icon(
            icon: _icon,
            label: _label,
            onPressed: _onPressed,
          ),
        ),
      ],
    );
  }

  void _buildNeeds() async {
    if (_appId == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _appId = packageInfo.packageName;
    }
    _downPath ??= "${await Paths.localPath(context)}/palm_green_latest.apk";
  }

  void _onPressed() {
    // 如果没下载, 就开始下载
    if (_value == 0) {
      _dio.download(widget.url, _downPath, onReceiveProgress: _onDownload);
      return;
    }

    if (_value == 1) {
      InstallPlugin.installApk(_downPath, _appId);
      return;
    }
  }

  void _onDownload(int downloaded, int total) {
    _value = downloaded / total;
    if (_value == 1) {
      _icon = Icon(
        CommunityMaterialIcons.arrow_down_bold,
        color: Colors.white,
      );
      _label = Text(
        FlutterI18n.translate(context, "widgets.dio_button.install"),
        style: TextStyle(color: Colors.white),
      );
    }
    setState(() {});
  }
}

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:palm_green/models/theme_color.dart';
import 'package:palm_green/utils/permissions.dart';
import 'package:palm_green/utils/protocol.dart';
import 'package:palm_green/widgets/easy_list.dart';
import 'package:provider/provider.dart';

class ProtocolPage extends StatefulWidget {
  @override
  _ProtocolPageState createState() => _ProtocolPageState();
}

class _ProtocolPageState extends State<ProtocolPage> {
  bool _accept = false;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text(FlutterI18n.translate(context, "views.protocol_page.title")),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _context = context;
          return Container(
            padding: EdgeInsets.all(10),
            child: EasyList(
              children: <Widget>[
                MarkdownBody(
                  data: """
# **软件声明**

掌上绿荫(以下简称本软件) 由南京工业大学绿荫工作室负责开发与维护, 现阶段仅用于内部成员交流和学校师生查看信息使用. 在本软件前, 您需要严格遵循以下几条使用协议: 

## **用户协议**

1. 作为本软件的使用者, 不得向校外范围散播本软件.
2. 不得使用本软件的通信功能发起不正当言论, 本软件严格执行南京工业大学所有条例和规范, 如果您的操作存在违规行为, 与本软件不予承担任何责任.
3. 使用本软件对您的手机带来任何的未知影响, 本软件不予承担任何责任.
4. 使用本软件的开源代码必须注明出处.

## **开源鸣谢**

以下排名不分先后, 感谢flutter开源项目对本软件的提供的重要帮助!

package_info 提供app信息拓展

dio 扩展网络模块

shared_preferences 本地化存储

provider 在Flutter上实现MVVM

path_provider 获取全平台环境路径信息

flutter_swiper 轮播图

flutter_easyrefresh 下拉刷新和更加美观的列表

cached_network_image 网络图片缓存

flutter_markdown 提供Markdown支持

permission_handler 权限申请

image_picker 图片选择器

install_plugin 应用内OTA实现

fluttertoast 弹出式通知

community_material_icon 图标拓展

flutter_i18n 国际化支持

flutter_local_notifications 全平台通知支持

web_socket_channel WebSocket支持

bubble 聊天气泡

webfeed rss订阅功能

# **权限需求**

本软件在使用时需要与服务器连接, 获取您向服务器授权的个人信息; 需要使用相机记录您个人资料页面的头像信息; 需要文件读写权限来存储和查询本软件UI的本地化样式信息. 如果您同意本协议, 意味着您将认可本软件对权限要求的合理性, 并愿意向本软件授权所有的权限.

本软件所需权限细节如下: 

```xml

<!-- 用户登录和获取网络图片等情况下需要网络权限支持 -->
<uses-permission android:name="android.permission.INTERNET" />

<!-- 选取用户头像和存储用户登录凭证等情况下需要本地存储权限支持 -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- 向用户推送自定义校园信息等情况下需要通知权限支持 -->
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.VIBRATE" />

<!-- 部分用户需要拍照上传个人头像时需要相机权限支持 -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Android平台app内部更新时需要app安装权限支持 -->
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
```

**勾选"我已阅读全部条款"并点击下方"确认"按钮, 代表您已同意并严格遵守本软件协议的全部内容.**
""",
                ),
                CheckboxListTile(
                  value: _accept,
                  activeColor:
                      Provider.of<ThemeColor>(context).primarySwatchColor,
                  title: Text(FlutterI18n.translate(
                      context, "views.protocol_page.read")),
                  onChanged: (value) {
                    setState(() {
                      _accept = !_accept;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      colorBrightness: Brightness.dark,
                      color: Colors.red,
                      icon: Icon(CommunityMaterialIcons.cancel),
                      label: Text(FlutterI18n.translate(
                          context, "views.protocol_page.decline")),
                      onPressed: () => SystemNavigator.pop(),
                    ),
                    Padding(padding: EdgeInsets.all(15)),
                    FlatButton.icon(
                      colorBrightness: Brightness.dark,
                      color: Colors.blue,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      label: Text(FlutterI18n.translate(
                          context, "views.protocol_page.confirm")),
                      onPressed: _onAccept,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(15)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onAccept() {
    if (_accept) {
      Provider.of<Protocol>(context, listen: false).setPass(true);
      Permissions();
    } else {
      SnackBar snackBar = SnackBar(
        content:
            Text(FlutterI18n.translate(context, "views.protocol_page.unread")),
      );
      Scaffold.of(_context).showSnackBar(snackBar);
    }
  }
}

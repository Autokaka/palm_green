import 'package:bubble/bubble.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/utils/im_client.dart';

class IMPage extends StatefulWidget {
  @override
  _IMPageState createState() => _IMPageState();
}

class _IMPageState extends State<IMPage> {
  IMClient _client;
  TextEditingController _controller = TextEditingController();
  List<Widget> _msgList = List<Widget>();

  @override
  void initState() {
    super.initState();
    _client = IMClient(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(FlutterI18n.translate(context, "views.im_page.title")),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: EasyRefresh.custom(
              header: MaterialHeader(),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _msgList[index];
                    },
                    childCount: _msgList?.length,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(CommunityMaterialIcons.microphone),
              onPressed: () => {},
            ),
            title: Container(
              height: 37,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[200]
                      : Colors.black38,
                ),
              ),
            ),
            trailing: Container(
              width: 60,
              child: FlatButton(
                colorBrightness: Brightness.dark,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text("发送"),
                onPressed: _sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (!_client.sendMessage(_controller.text)) return;
    setState(() {
      _msgList.add(Bubble(
        elevation: 0,
        nip: BubbleNip.rightTop,
        alignment: Alignment.centerRight,
        color: Theme.of(context).primaryColor,
        radius: Radius.circular(15),
        padding: BubbleEdges.symmetric(horizontal: 10, vertical: 10),
        margin: BubbleEdges.all(10),
        child: Text(
          _controller.text,
          style: TextStyle(color: Colors.white),
        ),
      ));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}

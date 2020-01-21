import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/views/article_page/article_page.dart';
import 'package:palm_green/views/blank.dart';
import 'package:palm_green/views/me_page/me_page.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> with SingleTickerProviderStateMixin {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      ArticlePage(),
      Blank(),
      Blank(),
      MePage(),
    ];
    final _items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(CommunityMaterialIcons.leaf),
        title: Text(FlutterI18n.translate(context, "views.frame.nav1")),
      ),
      BottomNavigationBarItem(
        icon: Icon(CommunityMaterialIcons.school),
        title: Text(FlutterI18n.translate(context, "views.frame.nav2")),
      ),
      BottomNavigationBarItem(
        icon: Icon(CommunityMaterialIcons.message),
        title: Text(FlutterI18n.translate(context, "views.frame.nav3")),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(FlutterI18n.translate(context, "views.frame.nav4")),
      ),
    ];
    final _bottomNavigationBar = BottomNavigationBar(
      items: _items,
      currentIndex: _i,
      type: BottomNavigationBarType.fixed,
      onTap: (int i) {
        setState(() {
          _i = i;
        });
      },
    );

    return Scaffold(
      body: IndexedStack(index: _i, children: _pages),
      bottomNavigationBar: _bottomNavigationBar,
    );
  }
}

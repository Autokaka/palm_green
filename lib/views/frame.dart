import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/views/article_page/article_page.dart';
import 'package:palm_green/views/me_page/me_page.dart';
import 'package:palm_green/views/msg_page/msg_page.dart';
import 'package:palm_green/views/school_page/school_page.dart';
import 'package:provider/provider.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame>
    with SingleTickerProviderStateMixin<Frame> {
  int _index = 0;
  bool _isOnline;
  List<BottomNavigationBarItem> _itemList = [];
  List<Widget> _pageList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isOnline == Provider.of<User>(context, listen: true).isOnline) return;

    _isOnline = Provider.of<User>(context, listen: true).isOnline;
    if (_isOnline && _pageList.length == 3 && _index == 2) _index = 3;
    if (!_isOnline && _pageList.length == 4 && _index == 3) _index = 2;

    _setItemList();
    _setPageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _itemList,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }

  void _setPageList() {
    _pageList = [
      ArticlePage(),
      SchoolPage(),
      MsgPage(),
      MePage(),
    ];
    if (!_isOnline) _pageList.removeAt(2);
  }

  void _setItemList() {
    _itemList = [
      BottomNavigationBarItem(
        title: Text(FlutterI18n.translate(context, "views.frame.nav1")),
        icon: Icon(CommunityMaterialIcons.leaf),
      ),
      BottomNavigationBarItem(
        title: Text(FlutterI18n.translate(context, "views.frame.nav2")),
        icon: Icon(CommunityMaterialIcons.school),
      ),
      BottomNavigationBarItem(
        title: Text(FlutterI18n.translate(context, "views.frame.nav3")),
        icon: Icon(CommunityMaterialIcons.message),
      ),
      BottomNavigationBarItem(
        title: Text(FlutterI18n.translate(context, "views.frame.nav4")),
        icon: Icon(Icons.person),
      ),
    ];
    if (!_isOnline) _itemList.removeAt(2);
  }
}

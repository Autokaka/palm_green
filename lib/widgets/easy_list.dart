import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class EasyList extends StatelessWidget {
  final List<Widget> children;

  EasyList({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }
}

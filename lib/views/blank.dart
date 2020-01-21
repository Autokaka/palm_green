import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Blank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.blank.title")),
      ),
    );
  }
}

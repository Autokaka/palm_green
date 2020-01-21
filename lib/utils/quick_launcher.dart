import 'package:flutter/material.dart';

class QuickLauncher {
  static void go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}

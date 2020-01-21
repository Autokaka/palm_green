import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Paths {
  static Future<String> localPath(BuildContext context) async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory.path;
  }
}

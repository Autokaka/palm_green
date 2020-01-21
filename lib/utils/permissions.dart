import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static final List<PermissionGroup> permissionList = [
    PermissionGroup.storage,
    PermissionGroup.notification,
  ];

  Permissions() {
    _initState();
  }

  void _initState() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(permissionList);

    for (var ask in permissionList) {
      if (permissions[ask] != PermissionStatus.granted) {
        Fluttertoast.showToast(
          msg: "权限 $ask 申请被拒绝, 应用程序可能无法正常工作",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.yellow,
          textColor: Colors.white,
        );
      }
    }
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiManager {
  FlutterLocalNotificationsPlugin _plugin;
  AndroidInitializationSettings _androidSetting;
  IOSInitializationSettings _iosSetting;
  InitializationSettings _globalSetting;
  Future<dynamic> Function(int, String, String, String) _onReceive;
  Future<dynamic> Function(String) _onTap;

  NotiManager() {
    _plugin = FlutterLocalNotificationsPlugin();
    _androidSetting = AndroidInitializationSettings('ic_launcher');

    _onReceive = _onReceiveDefault;
    _onTap = _onTapDefault;

    _iosSetting = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onReceive,
    );
    _globalSetting = InitializationSettings(_androidSetting, _iosSetting);

    _plugin.initialize(
      _globalSetting,
      onSelectNotification: _onTap,
    );
  }

  get plugin => _plugin;
  get androidSetting => _androidSetting;
  get iosSetting => _iosSetting;
  get globalSetting => _globalSetting;

  // For IOS only
  void bindReceive(
      Future<dynamic> Function(int, String, String, String) onReceive) {
    _onReceive = onReceive;
    _iosSetting = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onReceive,
    );
    _plugin.initialize(
      _globalSetting,
      onSelectNotification: _onTap,
    );
  }

  // For all platform, when notification is tapped (Notice that this method is quite dangerous!)
  void bindTap(Future<dynamic> Function(String) onTap) {
    _onTap = onTap;
    _plugin.initialize(
      _globalSetting,
      onSelectNotification: _onTap,
    );
  }

  Future<void> _onReceiveDefault(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    print("(Default) onDidReceiveLocalNotification");
    print(id);
    print(title);
    print(body);
    print(payload);
  }

  Future<void> _onTapDefault(String payload) async {
    print("(Default) onSelectNotification");
    print(payload);
  }
}

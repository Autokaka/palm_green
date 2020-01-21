import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeColor with ChangeNotifier {
  MaterialColor _primarySwatchColor = Colors.blue;
  Brightness _brightness = Brightness.light;
  bool _followSystem = true;

  static const String PRIMARY_SWATCH = "primarySwatch";
  static const String IS_DARK = "isDark";
  static const String FOLLOW_SYSTEM = "followSystem";
  static const Map<String, MaterialColor> materialColorMap = {
    "blue": Colors.blue,
    "green": Colors.green,
    "pink": Colors.pink,
    "indigo": Colors.indigo,
    "teal": Colors.teal,
  };

  ThemeColor() {
    _initState();
  }

  get primarySwatchColor => _primarySwatchColor;
  get brightness => _brightness;
  get followSystem => _followSystem;

  void setPrimarySwatchColor(MaterialColor color) async {
    if (color == _primarySwatchColor) return;
    _primarySwatchColor = color;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorKey = "blue";
    for (colorKey in materialColorMap.keys) {
      if (materialColorMap[colorKey] == color) break;
    }
    prefs.setString(PRIMARY_SWATCH, colorKey);
  }

  void setBrightness(Brightness brightness) async {
    if (brightness == _brightness) return;
    _brightness = brightness;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DARK, (brightness == Brightness.dark));
  }

  void setFollowSystem(bool followSystem) async {
    if (_followSystem == followSystem) return;
    _followSystem = followSystem;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(FOLLOW_SYSTEM, _followSystem);
  }

  void setThemeColor(MaterialColor color, Brightness brightness) async {
    if (color == _primarySwatchColor && brightness == _brightness) return;
    _primarySwatchColor = color;
    _brightness = brightness;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorKey = "blue";
    for (colorKey in materialColorMap.keys) {
      if (materialColorMap[colorKey] == color) break;
    }
    prefs.setString(PRIMARY_SWATCH, colorKey);
    prefs.setBool(IS_DARK, (brightness == Brightness.dark));
  }

  void _initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String primarySwatch = prefs.getString(PRIMARY_SWATCH) ?? "blue";
    bool isDark = prefs.getBool(IS_DARK) ?? false;
    bool followSystem = prefs.getBool(FOLLOW_SYSTEM) ?? true;

    _primarySwatchColor = materialColorMap[primarySwatch] ?? Colors.blue;
    _brightness = isDark ? Brightness.dark : Brightness.light;
    _followSystem = followSystem;

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/utils/version_manager.dart';
import 'package:palm_green/views/frame.dart';
import 'package:palm_green/models/theme_color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeColor>(create: (_) => ThemeColor()),
        ChangeNotifierProvider<User>(create: (_) => User()),
        ChangeNotifierProvider<VersionManager>(create: (_) => VersionManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 国际化
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: true,
          fallbackFile: "zh_CN",
          path: "assets/i18n",
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      title: '掌上绿荫',
      theme: ThemeData(
        primarySwatch: Provider.of<ThemeColor>(context).primarySwatchColor,
        brightness: Provider.of<ThemeColor>(context).brightness,
      ),
      darkTheme: Provider.of<ThemeColor>(context).followSystem
          ? ThemeData.dark()
          : null, // 监听系统夜间模式
      home: Frame(),
    );
  }
}

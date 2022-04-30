import 'package:flutter/material.dart';
import './custom_theme_color.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: Colors.white,
    listTileTheme: ListTileThemeData(
      tileColor: dTextstyle.color,
      iconColor: lTextstyle.color,
      textColor: lTextstyle.color,
    ),
    textTheme: const TextTheme(
      bodyText1: lTextstyle,
      bodyText2: lTextstyle,
      headline1: lTextstyle,
      subtitle1: lTextstyle,
      subtitle2: lTextstyle,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

  /// 夜晚模式
  static ThemeData dark = ThemeData(
    primaryColor: Colors.black,
    listTileTheme: ListTileThemeData(
      tileColor: lTextstyle.color,
      iconColor: dTextstyle.color,
      textColor: dTextstyle.color,
    ),
    textTheme: const TextTheme(
      bodyText1: dTextstyle,
      bodyText2: dTextstyle,
      headline1: dTextstyle,
      subtitle1: dTextstyle,
      subtitle2: dTextstyle,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white)),
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
}

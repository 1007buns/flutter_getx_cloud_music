import 'package:flutter/material.dart';

import 'custom_indicator_round.dart';
import 'custom_theme_color.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: Colors.grey, // 主色调
    highlightColor: Color.fromRGBO(0, 0, 0, 0),
    splashColor: Color.fromRGBO(0, 0, 0, 0),

    tabBarTheme: const TabBarTheme(
      labelPadding: EdgeInsets.only(left: 30, right: 30, bottom: 6),
      labelStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 16.0),
      indicator: CustomIndicatorRound(
        borderSide: BorderSide(color: Colors.black, width: 4.0),
        insets: EdgeInsets.only(top: 3.0, bottom: 5.0, left: 15, right: 15),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
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
    highlightColor: Color.fromRGBO(0, 0, 0, 0),
    splashColor: Color.fromRGBO(0, 0, 0, 0),
    tabBarTheme: const TabBarTheme(
      labelPadding: EdgeInsets.only(left: 30, right: 30, bottom: 6),
      labelStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 16.0),
      indicator: CustomIndicatorRound(
        borderSide: BorderSide(color: Colors.pink, width: 4.0),
        insets: EdgeInsets.only(top: 3.0, bottom: 5.0, left: 15, right: 15),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
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

import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'theme_color.dart';

enum SupportedTheme { light, dark }

extension SupportedThemeExt on SupportedTheme {
  String get name {
    switch (this) {
      case SupportedTheme.light:
        return 'light';
      default:
        return 'dark';
    }
  }
}

class AppTheme {
  final String name;
  final ThemeData data;

  const AppTheme(this.name, this.data);
}

AppTheme buildLightTheme() {
  return AppTheme(
    'light',
    ThemeData(
      brightness: Brightness.light,
      // fontFamily: 'Inter',
      primaryColorLight: themeColor.primaryColorLight,
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: themeColor.cardBackground,
      cardColor: themeColor.cardBackground,
      textTheme: AppTextTheme.getDefaultTextTheme(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: themeColor.primaryColor,
      ),
      unselectedWidgetColor: Colors.grey,
      selectedRowColor: themeColor.primaryColor,
    ),
  );
}

AppTheme buildDarkTheme() {
  return AppTheme(
    'dark',
    ThemeData(
      brightness: Brightness.dark,
      // fontFamily: 'Inter',
      primaryColorLight: themeColor.primaryColorLight,
      primaryColor: ThemeData.dark().primaryColor,
      scaffoldBackgroundColor: ThemeData.dark().primaryColor,
      cardColor: const Color(0xFF3e3c43),
      textTheme: AppTextTheme.getDefaultTextThemeDark(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: themeColor.primaryColor,
      ),
      unselectedWidgetColor: Colors.grey,
      selectedRowColor: themeColor.primaryColor,
    ),
  );
}

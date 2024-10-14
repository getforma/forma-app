import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.pureWhite,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.pureWhite),
  );

  static ThemeData dark = ThemeData(brightness: Brightness.dark);
}

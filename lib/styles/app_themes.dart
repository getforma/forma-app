import 'package:flutter/material.dart';
import 'package:forma_app/styles/app_colors.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.pureWhite,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.pureWhite),
  );

  static ThemeData dark = ThemeData(brightness: Brightness.dark);
}

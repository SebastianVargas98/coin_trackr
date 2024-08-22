import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final appThemeMode = ThemeData().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppColors.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(height: 0, color: AppColors.transparentColor),
      hintStyle: TextStyle(
        color: Color(0xffADA4A5),
      ),
      border: InputBorder.none,
    ),
  );
}

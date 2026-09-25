import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

const AppBarTheme _globalAppBarTheme = AppBarTheme(
  backgroundColor: AppColors.primaryColor,
  foregroundColor: Colors.white,
  elevation: 0,
  scrolledUnderElevation: 0,
  surfaceTintColor: Colors.transparent,
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.white),
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);

// Light Theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
  ),
  appBarTheme: _globalAppBarTheme,
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColor,
  ),
  appBarTheme: _globalAppBarTheme,
);

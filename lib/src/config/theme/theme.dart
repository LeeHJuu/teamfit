import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: CustomColor.primary_60,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(
    color: CustomColor.gray_80,
    indent: 20,
    endIndent: 20,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        // width: 1.2,
        color: CustomColor.primary_60,
        style: BorderStyle.solid,
      ),
      backgroundColor: CustomColor.primary_95,
      foregroundColor: Colors.black,
    ),
  ),
);

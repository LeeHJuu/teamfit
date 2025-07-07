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
);

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

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
  // FilledButton 공통 스타일
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: CustomColor.primary_60,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: CustomText.Body_Heavy_M_14,
      elevation: 0,
      shadowColor: Colors.transparent,
    ),
  ),
  // OutlinedButton 공통 스타일
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: CustomColor.primary_60,
      side: BorderSide(
        color: CustomColor.primary_60,
        width: 1.2,
        style: BorderStyle.solid,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: CustomText.Body_Heavy_M_14,
      elevation: 0,
      shadowColor: Colors.transparent,
    ),
  ),
);

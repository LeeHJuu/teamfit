import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class CustomText {
  static const double letterSpacing = -0.02;

  // 기본 텍스트 스타일
  static TextStyle _headlineStyle(double fontSize, Color color) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.35, // 135% line height
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle _bodyStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.5, // 150% line height
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  // 헤드라인 스타일
  static TextStyle Headline_L_28 = _headlineStyle(28, CustomColor.gray_10);
  static TextStyle Headline_M_26 = _headlineStyle(26, CustomColor.gray_10);
  static TextStyle Headline_S_24 = _headlineStyle(24, CustomColor.gray_10);

  // 타이틀 스타일
  static TextStyle Title_L_22 = _headlineStyle(22, CustomColor.gray_10);
  static TextStyle Title_M_20 = _headlineStyle(20, CustomColor.gray_10);
  static TextStyle Title_S_18 = _headlineStyle(18, CustomColor.gray_10);

  // 서브타이틀 스타일
  static TextStyle Subtitle_M_16 = _headlineStyle(16, CustomColor.gray_20);

  // 라벨 스타일
  static TextStyle Label_Heavy_L_20 = _bodyStyle(
    20,
    FontWeight.w700,
    CustomColor.gray_30,
  );
  static TextStyle Label_Light_L_20 = _bodyStyle(
    20,
    FontWeight.w500,
    CustomColor.gray_30,
  );
  static TextStyle Label_Heavy_M_16 = _bodyStyle(
    16,
    FontWeight.w700,
    CustomColor.gray_30,
  );
  static TextStyle Label_Light_M_16 = _bodyStyle(
    16,
    FontWeight.w500,
    CustomColor.gray_30,
  );
  static TextStyle Label_Heavy_S_14 = _bodyStyle(
    14,
    FontWeight.w700,
    CustomColor.gray_30,
  );
  static TextStyle Label_Light_S_14 = _bodyStyle(
    14,
    FontWeight.w500,
    CustomColor.gray_30,
  );
  static TextStyle Label_Heavy_XS_12 = _bodyStyle(
    12,
    FontWeight.w700,
    CustomColor.gray_30,
  );
  static TextStyle Label_Light_XS_12 = _bodyStyle(
    12,
    FontWeight.w500,
    CustomColor.gray_30,
  );

  // 바디 스타일
  static TextStyle Body_Heavy_M_14 = _bodyStyle(
    14,
    FontWeight.w600,
    CustomColor.gray_30,
  );
  static TextStyle Body_Light_M_14 = _bodyStyle(
    14,
    FontWeight.w400,
    CustomColor.gray_30,
  );
  static TextStyle Body_Heavy_S_13 = _bodyStyle(
    13,
    FontWeight.w600,
    CustomColor.gray_30,
  );
  static TextStyle Body_Light_S_13 = _bodyStyle(
    13,
    FontWeight.w400,
    CustomColor.gray_30,
  );
  static TextStyle Body_Heavy_XS_12 = _bodyStyle(
    12,
    FontWeight.w600,
    CustomColor.gray_30,
  );
  static TextStyle Body_Light_XS_12 = _bodyStyle(
    12,
    FontWeight.w400,
    CustomColor.gray_30,
  );
  static TextStyle Body_Heavy_XXS_11 = _bodyStyle(
    11,
    FontWeight.w600,
    CustomColor.gray_30,
  );
  static TextStyle Body_Light_XXS_11 = _bodyStyle(
    11,
    FontWeight.w400,
    CustomColor.gray_30,
  );

  // 캡션 스타일
  static TextStyle Caption_M_10 = _bodyStyle(
    10,
    FontWeight.w400,
    CustomColor.gray_40,
  );
}

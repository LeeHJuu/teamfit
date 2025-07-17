import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class TestStepTitle extends StatelessWidget {
  String sub;
  String title;

  TestStepTitle(this.sub, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sub,
            style: CustomText.Title_S.copyWith(color: CustomColor.gray_10),
          ),
          Text(
            title,
            style: CustomText.Headline_S.copyWith(color: CustomColor.gray_10),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class TestStepTitle extends StatelessWidget {
  String sub;
  String title;

  TestStepTitle(this.sub, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(sub, style: CustomText.Title_S_18),
          SizedBox(height: 10),
          Text(title, style: CustomText.Headline_S_24),
        ],
      ),
    );
  }
}

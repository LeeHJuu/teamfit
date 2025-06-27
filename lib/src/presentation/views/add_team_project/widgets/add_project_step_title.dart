import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class AddProjectStepTitle extends StatelessWidget {
  String nowStep;
  String allStep;
  String title;

  AddProjectStepTitle({
    required this.nowStep,
    required this.allStep,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(nowStep, style: CustomText.Headline_M),
              Text(allStep, style: CustomText.Subtitle_M),
            ],
          ),
          Text(title, style: CustomText.Headline_M),
        ],
      ),
    );
  }
}

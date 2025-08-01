import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class NextStepBottomButton extends StatelessWidget {
  String title;
  bool isPossible;
  void Function() moveNext;

  NextStepBottomButton({
    required this.title,
    required this.isPossible,
    required this.moveNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: FilledButton(
          onPressed: isPossible ? moveNext : null, // 비활성화 상태에서는 null을 설정
          style: FilledButton.styleFrom(
            backgroundColor:
                isPossible ? CustomColor.primary_60 : CustomColor.gray_90,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          child: Text(
            title,
            style: CustomText.Subtitle_M.copyWith(
              color: isPossible ? Colors.white : CustomColor.gray_50,
            ),
          ),
        ),
      ),
    );
  }
}

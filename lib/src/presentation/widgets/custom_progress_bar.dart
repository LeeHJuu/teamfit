import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 ~ 1.0 범위의 값

  CustomProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // 배경 막대 (grey95, 100% 길이)
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: CustomColor.gray_95,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // 진행 막대 (primary60, 진행비율만큼의 길이)
          Container(
            height: 10,
            width:
                MediaQuery.of(context).size.width *
                0.8 *
                progress, // 패딩을 고려한 너비 계산
            decoration: BoxDecoration(
              color: CustomColor.primary_60,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}

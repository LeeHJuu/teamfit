import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 ~ 1.0 범위의 값

  CustomProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: (progress * 100).toInt(), // 진행 비율에 따라 너비 설정
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: CustomColor.primary_60,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Expanded(
            flex: 100 - (progress * 100).toInt(), // 남은 비율
            child: Container(
              color: Colors.transparent, // 남은 부분은 투명하게 설정
            ),
          ),
        ],
      ),
    );
  }
}

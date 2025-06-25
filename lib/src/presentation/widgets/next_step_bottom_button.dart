import 'package:flutter/material.dart';

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
        height: 50,
        width: double.infinity,
        child: FilledButton(
          onPressed: isPossible ? moveNext : null, // 비활성화 상태에서는 null을 설정
          style: FilledButton.styleFrom(
            backgroundColor: isPossible ? Colors.amber : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(14),
            ),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

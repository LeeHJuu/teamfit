import 'package:flutter/material.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class MotivationalCard extends StatelessWidget {
  final String emoji;
  final String message;

  const MotivationalCard({
    super.key,
    this.emoji = '🔥',
    this.message = '멤버들이 일정을 모두 완수하고 있어요! 어서 분발하세요!',
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

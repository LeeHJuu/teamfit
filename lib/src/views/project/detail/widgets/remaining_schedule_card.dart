import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class RemainingScheduleCard extends StatelessWidget {
  final int remainingCount;
  final VoidCallback? onRecordPressed;

  const RemainingScheduleCard({
    super.key,
    this.remainingCount = 1,
    this.onRecordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.alarm, color: CustomColor.primary_60, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '아직 ${remainingCount}개의 남은 일정이 있어요!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onRecordPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.primary_60,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('기록하고 열정온도 올리기'),
          ),
        ],
      ),
    );
  }
}

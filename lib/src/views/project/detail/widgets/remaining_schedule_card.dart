import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

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
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
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

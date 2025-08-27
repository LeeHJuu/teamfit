import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class ProgressStatusCard extends StatelessWidget {
  final int round;
  final int remainingDays;
  final double progress;
  final String message;

  const ProgressStatusCard({
    super.key,
    this.round = 1,
    this.remainingDays = 3,
    this.progress = 0.5,
    this.message = '1회차의 남은 기간은 단 3일! 얼른 과제를 완수해 주세요~',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.hourglass_empty,
                color: CustomColor.primary_60,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '${round}회차 진행 현황',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColor.primary_60,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.primary_60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

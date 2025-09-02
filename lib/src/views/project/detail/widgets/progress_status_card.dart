import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

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
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 12),
          _buildMessage(),
          SizedBox(height: 16),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.hourglass_empty, color: CustomColor.primary_60, size: 24),
        SizedBox(width: 8),
        Text(
          '${round}회차 진행 현황',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildMessage() {
    return Text(
      message,
      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(CustomColor.primary_60),
            minHeight: 16,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 12),
        Text('${(progress * 100).toInt()}%'),
      ],
    );
  }
}

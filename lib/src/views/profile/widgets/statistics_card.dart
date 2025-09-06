import 'package:flutter/material.dart';
import '../../../models/user_data.dart';
import '../../../config/theme/custom_color.dart';
import '../../../config/theme/custom_text.dart';

class StatisticsCard extends StatelessWidget {
  final UserData member;

  const StatisticsCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // MVP 횟수
        Expanded(
          child: _buildStatItem('MVP', '${member.detailData?.mvpCount ?? 0}번'),
        ),
        // 구분선
        Container(width: 1, height: 40, color: CustomColor.gray_80),
        // 출석율
        Expanded(
          child: _buildStatItem(
            '출석율',
            '${member.detailData?.attendanceRate?.toInt() ?? 0}%',
          ),
        ),
        // 구분선
        Container(width: 1, height: 40, color: CustomColor.gray_80),
        // 총 시간
        Expanded(child: _buildStatItem('총 시간', _formatTotalTime())),
      ],
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: CustomText.Label_Heavy_M_16.copyWith(
            color: CustomColor.gray_10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: CustomText.Body_Light_M_14.copyWith(
            color: CustomColor.gray_60,
          ),
        ),
      ],
    );
  }

  String _formatTotalTime() {
    // 임시로 계산된 총 시간 (실제로는 프로젝트별 작업 시간을 합산해야 함)
    final totalHours = 139;
    final totalMinutes = 21;
    final totalSeconds = 20;
    return '${totalHours}:${totalMinutes.toString().padLeft(2, '0')}:${totalSeconds.toString().padLeft(2, '0')}';
  }
}

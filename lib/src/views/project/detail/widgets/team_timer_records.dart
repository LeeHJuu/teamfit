import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class TeamTimerRecords extends StatelessWidget {
  final String teamName;
  final List<TimerRecord> records;
  final VoidCallback? onViewDetails;

  const TeamTimerRecords({
    super.key,
    this.teamName = '무적팀',
    required this.records,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$teamName 팀원들의 타이머 기록!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            '진행 현황 탭으로 가면 더 자세한 현황을 확인할 수 있어요~',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  records.map((record) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: _buildTimerRecordItem(record),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerRecordItem(TimerRecord record) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.person, color: Colors.grey[600], size: 30),
            ),
            Positioned(
              top: 2,
              left: 2,
              child: Icon(
                Icons.local_fire_department,
                color: CustomColor.primary_60,
                size: 24,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          record.name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Text(
          record.time,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class TimerRecord {
  final String name;
  final String time;

  TimerRecord({required this.name, required this.time});
}

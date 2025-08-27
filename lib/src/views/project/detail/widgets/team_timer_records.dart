import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

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
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600], size: 30),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: CustomColor.primary_60,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 12,
                ),
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

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/models/schedule_data.dart';

class ScheduleDetailInputSection extends StatelessWidget {
  final int roundNumber;
  final ScheduleData scheduleData;
  final TextEditingController scheduleController;
  final VoidCallback onDatePressed;

  const ScheduleDetailInputSection({
    super.key,
    required this.roundNumber,
    required this.scheduleData,
    required this.scheduleController,
    required this.onDatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 회차 정보와 날짜 선택
        Row(
          children: [
            Container(
              // width: 40,
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                color: CustomColor.primary_60,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$roundNumber회차',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: onDatePressed,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4),
                    Text(
                      '날짜를 등록해주세요',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // 일정 입력 필드
        Container(
          height: 120,
          child: TextField(
            controller: scheduleController,
            decoration: InputDecoration(
              hintText: '$roundNumber회차 일정을 작성해주세요',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: CustomColor.gray_95,
              contentPadding: EdgeInsets.all(12),
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),

        // 글자 수 표시
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '0/50',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}

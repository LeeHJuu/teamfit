import 'package:flutter/material.dart';

class ScheduleInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onDatePressed;

  const ScheduleInputBox({
    super.key,
    required this.controller,
    required this.onDatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 120),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 텍스트 필드 - 남은 공간을 최대로 사용
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '일정을 입력하세요',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              maxLines: null, // 무제한 줄 수
              expands: true, // 사용 가능한 공간을 모두 사용
              textAlignVertical: TextAlignVertical.top,
            ),
          ),

          // 하단 날짜 입력 영역
          GestureDetector(
            onTap: onDatePressed,
            child: Container(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
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
    );
  }
}

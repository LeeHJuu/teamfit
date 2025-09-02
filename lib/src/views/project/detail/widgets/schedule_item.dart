import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ScheduleItem extends StatelessWidget {
  final String duration; // "09:30 AM - 11:00 AM" 형태로 받음
  final String title;
  final String description;
  final int participantCount;

  const ScheduleItem({
    super.key,
    required this.duration,
    required this.title,
    required this.description,
    this.participantCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeIndicator(),
        Expanded(child: _buildScheduleContent()),
      ],
    );
  }

  Widget _buildTimeIndicator() {
    // duration에서 시작시간 추출 및 파싱
    final startTime = _extractStartTime(duration);
    final timeAndAmPm = _parseTimeAndAmPm(startTime);

    if (timeAndAmPm != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 4,
            width: 50,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: CustomColor.primary_60,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
          Text(
            timeAndAmPm['time']!,
            style: CustomText.Label_Light_XS_12.copyWith(
              color: CustomColor.primary_60,
            ),
            textAlign: TextAlign.right,
          ),
          Text(
            timeAndAmPm['ampm']!,
            style: CustomText.Caption_M_10.copyWith(
              color: CustomColor.primary_60,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      );
    }

    // 파싱 실패시 기존 방식으로 fallback
    return Container(
      width: 50,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: CustomColor.primary_60, width: 4),
        ),
      ),
      child: Text(
        startTime,
        style: CustomText.Label_Light_XS_12.copyWith(
          color: CustomColor.primary_60,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildScheduleContent() {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDurationText(),
          SizedBox(height: 4),
          _buildTitleRow(),
          SizedBox(height: 4),
          _buildDescriptionText(),
        ],
      ),
    );
  }

  Widget _buildDurationText() {
    return Text(
      duration,
      style: CustomText.Body_Light_XS_12.copyWith(color: CustomColor.gray_40),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Spacer(),
        _buildParticipantIndicator(),
      ],
    );
  }

  Widget _buildParticipantIndicator() {
    return Row(
      children: [
        Icon(Icons.person, color: Colors.grey, size: 20),
        Icon(Icons.person, color: Colors.grey, size: 20),
        SizedBox(width: 4),
        Text(
          '+${participantCount}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      description,
      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    );
  }

  // duration에서 시작시간 추출하는 헬퍼 메서드 (개선)
  String _extractStartTime(String duration) {
    // 다양한 형태의 구분자를 고려
    final separators = [' - ', '-', ' ~ ', '~', ' to ', ' TO '];

    for (final separator in separators) {
      final index = duration.indexOf(separator);
      if (index != -1) {
        return duration.substring(0, index).trim();
      }
    }

    return duration.trim(); // 구분자가 없으면 전체를 반환
  }

  // 시간과 AM/PM을 분리하는 헬퍼 메서드 (수정)
  Map<String, String>? _parseTimeAndAmPm(String timeString) {
    timeString = timeString.trim();

    // 시간만 있는 경우 (AM/PM 없음) - 24시간 형식 또는 12시간 형식
    final timeRegexPatterns = [
      r'^(\d{1,2}):(\d{2})$', // "09:30" 형식
      r'^(\d{1,2})시\s*(\d{1,2})분$', // "9시 30분" 형식
      r'^(\d{1,2})\.(\d{2})$', // "9.30" 형식
    ];

    for (final pattern in timeRegexPatterns) {
      final regex = RegExp(pattern);
      final match = regex.firstMatch(timeString);

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        String minute = match.group(2)!;

        // 12시간 형식으로 변환 및 AM/PM 판단
        String ampm;
        String displayHour;

        if (hour == 0) {
          // 자정 (00:xx) -> 12:xx AM
          displayHour = '12';
          ampm = 'AM';
        } else if (hour < 12) {
          // 오전 (01:xx ~ 11:xx) -> 1:xx AM ~ 11:xx AM
          displayHour = hour.toString();
          ampm = 'AM';
        } else if (hour == 12) {
          // 정오 (12:xx) -> 12:xx PM
          displayHour = '12';
          ampm = 'PM';
        } else {
          // 오후 (13:xx ~ 23:xx) -> 1:xx PM ~ 11:xx PM
          displayHour = (hour - 12).toString();
          ampm = 'PM';
        }

        return {'time': '$displayHour:$minute', 'ampm': ampm};
      }
    }

    // 시간 형식이 맞지 않는 경우
    return null;
  }
}

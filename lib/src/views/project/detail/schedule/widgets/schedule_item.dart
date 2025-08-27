import 'package:flutter/material.dart';
import 'package:teamfit/src/models/schedule_data.dart';
import 'schedule_round_box.dart';
import 'schedule_input_box.dart';
import 'dashed_line_painter.dart';

class ScheduleItem extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final ScheduleData scheduleData;

  const ScheduleItem({
    super.key,
    required this.index,
    required this.controller,
    required this.scheduleData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 회차 박스
        ScheduleRoundBox(roundNumber: index + 1, scheduleData: scheduleData),

        // 점선과 인풋박스 Row
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 좌측 점선 - 인풋박스 높이에 맞춤
              SizedBox(
                width: 40,
                child: CustomPaint(painter: DashedLinePainter()),
              ),
              SizedBox(width: 16),

              // 우측 인풋박스 (하단 여백 20, 인풋박스 높이 넉넉하게)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _scheduleInputBox(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scheduleInputBox(BuildContext context) {
    return ScheduleInputBox(
      controller: controller,
      onDatePressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: scheduleData.startDate,
          firstDate: DateTime(2024),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          print('Selected date: $picked for schedule: ${scheduleData.id}');
        }
      },
    );
  }
}

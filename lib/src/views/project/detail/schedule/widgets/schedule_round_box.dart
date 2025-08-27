import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/models/schedule_data.dart';
import 'package:teamfit/src/views/project/detail/schedule_detail/schedule_detail_page.dart';

class ScheduleRoundBox extends StatelessWidget {
  final int roundNumber;
  final ScheduleData? scheduleData;

  const ScheduleRoundBox({
    super.key,
    required this.roundNumber,
    this.scheduleData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: CustomColor.primary_60,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child:
                roundNumber == 0
                    ? Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 24,
                    )
                    : Text(
                      roundNumber.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          roundNumber == 0 ? '스터디 시작!' : '회차',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Spacer(),
        if (roundNumber != 0)
          IconButton(
            onPressed: () {
              if (scheduleData != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ScheduleDetailPage(
                          scheduleData: scheduleData!,
                          roundNumber: roundNumber,
                        ),
                  ),
                );
              }
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class ScheduleRoundBox extends StatelessWidget {
  final int roundNumber;

  const ScheduleRoundBox({super.key, required this.roundNumber});

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
              // TODO: 원하는 동작 추가
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}

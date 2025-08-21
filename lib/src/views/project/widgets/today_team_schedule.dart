import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class TodayTeamSchedule extends StatelessWidget {
  const TodayTeamSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('오늘의 팀일정', style: CustomText.Title_S_18),
          ),
        ],
      ),
    );
  }
}

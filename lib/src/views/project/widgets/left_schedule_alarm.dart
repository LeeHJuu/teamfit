import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class LeftScheduleAlarm extends StatelessWidget {
  const LeftScheduleAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.alarm),
          Text('아직 1개의 남은 일정이 있어요!', style: CustomText.Title_S_18),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text('기록하고 매너온도 올리기', style: CustomText.Title_S_18),
            ),
          ),
        ],
      ),
    );
  }
}

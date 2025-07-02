import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/project/project_home_tap_page/widgets/left_schedule_alarm.dart';
import 'package:teamfit/src/presentation/views/project/project_home_tap_page/widgets/today_team_schedule.dart';
import 'package:teamfit/src/presentation/widgets/rounded_container.dart';

class ProjectHomeTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('여기에 이번주 날자 달력이 표시됨'),
        Expanded(
          child: RoundedContainer(
            background: Colors.black12,
            body: Column(
              children: [
                Row(children: [Text('data'), Text('data')]),
                LeftScheduleAlarm(),
                TodayTeamSchedule(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

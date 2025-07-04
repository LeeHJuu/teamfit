import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/project_view_model.dart';
import 'package:teamfit/src/presentation/views/project/widgets/left_schedule_alarm.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_app_bar.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_bottom_navigation_bar.dart';
import 'package:teamfit/src/presentation/views/project/widgets/today_team_schedule.dart';
import 'package:teamfit/src/presentation/widgets/rounded_container.dart';

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectViewModel);
    return Scaffold(
      appBar: ProjectAppBar(),
      body: Column(
        children: [
          Text('여기에 이번주 날자 달력이 표시됨'),
          Expanded(
            child: RoundedContainer(
              background: Colors.black12,
              body: Column(
                children: [
                  _tapButton(),
                  SizedBox(height: 10),
                  LeftScheduleAlarm(),
                  TodayTeamSchedule(),
                  LeftScheduleAlarm(),
                  LeftScheduleAlarm(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProjectBottomNavigationBar(),
    );
  }

  Container _tapButton() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                print('1');
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text('data 1'),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                print('2');
              },
              child: Container(
                color: Colors.amber,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text('data 2'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

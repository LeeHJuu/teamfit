import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/project_view_model.dart';
import 'package:teamfit/src/presentation/views/project/project_home_tap_page/widgets/left_schedule_alarm.dart';
import 'package:teamfit/src/presentation/views/project/project_home_tap_page/widgets/today_team_schedule.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_app_bar.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_bottom_navigation_bar.dart';
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
                  Row(children: [Text('data'), Text('data')]),
                  LeftScheduleAlarm(),
                  TodayTeamSchedule(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProjectBottomNavigationBar(),
    );
  }
}

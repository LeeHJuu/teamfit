import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/views/project_callendar_tap_page/widgets/schedule_round_box.dart';
import 'package:teamfit/src/widgets/rounded_container.dart';
import 'package:teamfit/src/models/schedule_data.dart';
import 'widgets/schedule_item.dart';

class ProjectCallendarTapPage extends StatefulWidget {
  final String projectId = '1';

  const ProjectCallendarTapPage({super.key});

  @override
  _ProjectCallendarTapPageState createState() =>
      _ProjectCallendarTapPageState();
}

class _ProjectCallendarTapPageState extends State<ProjectCallendarTapPage> {
  List<ScheduleData> schedules = [];
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  void loadSchedules() {
    schedules = [
      ScheduleData(
        id: '1',
        title: '1회차',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 7)),
        createdBy: 'user1',
      ),
      ScheduleData(
        id: '2',
        title: '2회차',
        startDate: DateTime.now().add(Duration(days: 7)),
        endDate: DateTime.now().add(Duration(days: 14)),
        createdBy: 'user1',
      ),
      ScheduleData(
        id: '3',
        title: '3회차',
        startDate: DateTime.now().add(Duration(days: 14)),
        endDate: DateTime.now().add(Duration(days: 21)),
        createdBy: 'user1',
      ),
    ];

    for (var schedule in schedules) {
      controllers[schedule.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스케쥴'),
        backgroundColor: CustomColor.primary_60,
        foregroundColor: Colors.white,
      ),
      backgroundColor: CustomColor.primary_60,
      body: RoundedContainer(
        background: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // 스케쥴 데이터를 역순으로 표시 (높은 회차부터)
              ...schedules.reversed.map((schedule) {
                int index = schedules.indexOf(schedule);

                return ScheduleItem(
                  index: index,
                  controller: controllers[schedule.id]!,
                  scheduleData: schedule,
                );
              }),

              // 스터디 시작! 박스
              Center(child: ScheduleRoundBox(roundNumber: 0)),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

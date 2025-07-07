import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_schedule_preview.dart';
import 'package:teamfit/src/presentation/views/project_callendar_tap_page/project_callendar_tap_page.dart';
import 'package:teamfit/src/presentation/widgets/rounded_container.dart';

class ProjectSchedulePreviewBox extends StatelessWidget {
  const ProjectSchedulePreviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 70),
          _leftScheduleAlarm(context),
          ProjectSchedulePreview(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(onPressed: () {}, child: Text('스터디 기록하기')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leftScheduleAlarm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.all(20),
      // height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
      ),
      child: Row(
        children: [
          Text('3개의 일정이 있습니다.'),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

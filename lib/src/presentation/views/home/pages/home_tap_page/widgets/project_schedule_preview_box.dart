import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_schedule_preview.dart';
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
          _leftScheduleAlarm(),
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

  Container _leftScheduleAlarm() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
      ),
    );
  }
}

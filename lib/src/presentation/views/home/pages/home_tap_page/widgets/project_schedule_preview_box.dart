import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/widgets/rounded_container.dart';

class ProjectSchedulePreviewBox extends StatelessWidget {
  const ProjectSchedulePreviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: Colors.white,
      body: Column(
        children: [
          Text('data'),
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
}

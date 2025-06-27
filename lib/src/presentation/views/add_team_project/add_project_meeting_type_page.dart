import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_desired_roles_page.dart';
import 'package:teamfit/src/presentation/views/add_team_project/widgets/add_project_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectMeetingTypePage extends StatefulWidget {
  @override
  State<AddProjectMeetingTypePage> createState() =>
      _AddProjectMeetingTypePageState();
}

class _AddProjectMeetingTypePageState extends State<AddProjectMeetingTypePage> {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('팀 만들기', style: CustomText.Title_S)),
      body: Column(
        children: [
          AddProjectStepTitle(
            nowStep: '02',
            allStep: '/03',
            title: '협업 방식을 설정해주세요.',
          ),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectDesiredRolesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

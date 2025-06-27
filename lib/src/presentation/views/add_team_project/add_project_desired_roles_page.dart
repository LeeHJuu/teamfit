import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/add_team_project/finish_add_project_page.dart';
import 'package:teamfit/src/presentation/views/add_team_project/widgets/add_project_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectDesiredRolesPage extends StatefulWidget {
  @override
  State<AddProjectDesiredRolesPage> createState() =>
      _AddProjectDesiredRolesPageState();
}

class _AddProjectDesiredRolesPageState
    extends State<AddProjectDesiredRolesPage> {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('팀 만들기', style: CustomText.Title_S)),
      body: Column(
        children: [
          AddProjectStepTitle(
            nowStep: '03',
            allStep: '/03',
            title: '모집 인원과 바라는 팀원',
          ),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FinishAddProjectPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

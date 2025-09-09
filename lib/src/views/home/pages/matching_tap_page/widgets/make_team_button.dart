import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/project/create/add_project_goal_page.dart';

class MakeTeamButton extends StatelessWidget {
  const MakeTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectGoalPage()),
          );
        },
        child: Text('팀 만들기', style: CustomText.Subtitle_M_16),
      ),
    );
  }
}

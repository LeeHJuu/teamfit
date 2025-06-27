import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class AllTeamProjects extends StatelessWidget {
  const AllTeamProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('냥냥님을 위한 AI 추천 팀프로젝트', style: CustomText.Title_S),
        ),
        Text('data'),
        Text('data'),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class AIRecommendedTeamProjects extends StatelessWidget {
  const AIRecommendedTeamProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('전체 팀프로젝트', style: CustomText.Title_S),
        ),
        Text('data'),
        Text('data'),
      ],
    );
  }
}

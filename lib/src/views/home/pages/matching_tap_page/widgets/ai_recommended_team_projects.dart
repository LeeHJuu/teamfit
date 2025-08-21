import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/project_item_box.dart';

class AIRecommendedTeamProjects extends StatelessWidget {
  const AIRecommendedTeamProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('냥냥님을 위한 AI 추천 팀프로젝트', style: CustomText.Title_S_18),
        ),
        ProjectItemBox(),
        ProjectItemBox(),
      ],
    );
  }
}

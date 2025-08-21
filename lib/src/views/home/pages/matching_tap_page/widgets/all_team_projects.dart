import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/project_item_box.dart';

class AllTeamProjects extends StatelessWidget {
  const AllTeamProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('전체 팀프로젝트', style: CustomText.Title_S_18),
        ),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
        ProjectItemBox(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class RecommendedTeamProjects extends StatelessWidget {
  const RecommendedTeamProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('냥냥님을 위한 추천 팀프로젝트', style: CustomText.Title_S_18),
        ),
        RecommendedTeamProjectItem(),
      ],
    );
  }
}

class RecommendedTeamProjectItem extends StatelessWidget {
  const RecommendedTeamProjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      Column(
        children: [
          Container(width: double.infinity, height: 80, color: Colors.grey),
          Text('포트폴리오 제작'),
          Text('어쩌구저쩌구팀플모집제목'),
          Row(children: [Text('회의방식'), Text('인원'), Text('기한')]),
          Wrap(
            children: [
              Chip(label: Text('datadatadata')),
              Chip(label: Text('datadatadata')),
            ],
          ),
          Wrap(
            children: [
              Chip(label: Text('datada')),
              Chip(label: Text('data')),
              Chip(label: Text('data')),
              Chip(label: Text('data')),
            ],
          ),
        ],
      ),
    );
  }
}

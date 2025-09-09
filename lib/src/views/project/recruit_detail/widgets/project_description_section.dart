import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProjectDescriptionSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const ProjectDescriptionSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          SizedBox(height: 12),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text('프로젝트 개요', style: CustomText.Label_Heavy_M_16);
  }

  Widget _buildDescription() {
    return Text(
      recruitInfo.introduction,
      style: CustomText.Body_Light_M_14.copyWith(
        color: CustomColor.gray_30,
        height: 1.6,
      ),
    );
  }
}

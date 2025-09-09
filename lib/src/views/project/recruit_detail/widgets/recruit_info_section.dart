import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class RecruitInfoSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const RecruitInfoSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          SizedBox(height: 16),
          _buildRecruitList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text('모집 인원', style: CustomText.Label_Heavy_M_16);
  }

  Widget _buildRecruitList() {
    return Column(
      children:
          recruitInfo.recruitMembers.map((member) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: _buildRecruitItem(member),
            );
          }).toList(),
    );
  }

  Widget _buildRecruitItem(member) {
    // 현재 모집된 인원 수 (실제로는 API에서 가져와야 함)
    int currentCount = member.role.label == '디자인' ? 1 : 0;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.role.label, style: CustomText.Body_Heavy_M_14),
              SizedBox(height: 4),
              _buildTechTags(member.technologies),
            ],
          ),
        ),
        Text(
          '$currentCount / ${member.count}명',
          style: CustomText.Body_Heavy_M_14.copyWith(
            color:
                currentCount >= member.count
                    ? CustomColor.gray_50
                    : CustomColor.primary_60,
          ),
        ),
      ],
    );
  }

  Widget _buildTechTags(List<String> technologies) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children:
          technologies.map((tech) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: CustomColor.gray_95,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tech,
                style: CustomText.Body_Light_XS_12.copyWith(
                  color: CustomColor.gray_40,
                ),
              ),
            );
          }).toList(),
    );
  }
}

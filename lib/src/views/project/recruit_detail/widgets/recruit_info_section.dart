import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';

class RecruitInfoSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const RecruitInfoSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목을 외부로 분리
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('모집 인원', style: CustomText.Label_Heavy_M_16),
        ),
        SizedBox(height: 16),
        // 직무별로 ShadowBoxContainer 생성
        ...recruitInfo.recruitMembers.map((member) {
          return _buildRecruitMemberBox(member);
        }).toList(),
      ],
    );
  }

  Widget _buildRecruitMemberBox(member) {
    // 현재 모집된 인원 수 (실제로는 API에서 가져와야 함)
    int currentCount = member.role.label == '디자이너' ? 1 : 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(member.role.label, style: CustomText.Body_Heavy_M_14),
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
          ),
          SizedBox(height: 8),
          _buildTechTags(member.technologies),
        ],
      ),
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

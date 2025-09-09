import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProjectDetailsSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const ProjectDetailsSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          SizedBox(height: 16),
          _buildDetailsList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text('프로젝트 내용', style: CustomText.Label_Heavy_M_16);
  }

  Widget _buildDetailsList() {
    return Column(
      children: [
        _buildDetailItem('프로젝트 기간', recruitInfo.duration?.label ?? '미정'),
        _buildDetailItem('업무 방식', recruitInfo.meetingType?.label ?? '협의'),
        _buildDetailItem('회의 날짜 & 시간', '매주 월요일, 오후 6시'),
        _buildDetailItem('이런 분을 원해요!', _buildRequirementsList()),
      ],
    );
  }

  Widget _buildDetailItem(String title, dynamic content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: CustomText.Body_Heavy_S_13.copyWith(
                color: CustomColor.gray_40,
              ),
            ),
          ),
          Expanded(
            child:
                content is String
                    ? Text(
                      content,
                      style: CustomText.Body_Light_S_13.copyWith(
                        color: CustomColor.gray_20,
                      ),
                    )
                    : content,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsList() {
    final requirements = [
      '💡 실험적이고 창의적인 환경을 즐기는 분',
      '💜 의미 있는 일에 진심으로 임할 수 있는 분',
      '🍀 경험과 포트폴리오를 쌓고 싶은 분',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          requirements.map((requirement) {
            return Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                requirement,
                style: CustomText.Body_Light_S_13.copyWith(
                  color: CustomColor.gray_20,
                ),
              ),
            );
          }).toList(),
    );
  }
}

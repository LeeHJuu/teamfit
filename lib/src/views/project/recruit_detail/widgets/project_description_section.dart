import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';

class ProjectDescriptionSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const ProjectDescriptionSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목을 외부로 분리
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('프로젝트 개요', style: CustomText.Label_Heavy_M_16),
        ),
        SizedBox(height: 16),
        // ShadowBoxContainer 내부에 모든 정보
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 20),
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
              // 프로젝트 내용
              Text(
                '프로젝트 내용',
                style: CustomText.Body_Heavy_M_14.copyWith(
                  color: CustomColor.gray_20,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.gray_95,
                ),
                child: Text(
                  recruitInfo.introduction,
                  style: CustomText.Body_Light_M_14.copyWith(
                    color: CustomColor.gray_10,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 프로젝트 정보들
              _buildProjectInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      children: [
        _buildInfoRow('프로젝트 기간', '1개월'),
        SizedBox(height: 12),
        _buildInfoRow('업무 방식', '오프라인'),
        SizedBox(height: 12),
        _buildInfoRow('회의 날짜 & 시간', '매주 월요일, 오후 6시'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: CustomText.Body_Heavy_M_14.copyWith(
            color: CustomColor.gray_30,
          ),
        ),
        Text(
          value,
          style: CustomText.Body_Light_M_14.copyWith(
            color: CustomColor.gray_20,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';

class ProjectHeaderSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const ProjectHeaderSection({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          _buildProjectIcon(),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProjectTitle(),
                SizedBox(height: 8),
                _buildProjectSubtitle(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.rocket_launch, color: CustomColor.primary_60, size: 28),
    );
  }

  Widget _buildProjectTitle() {
    return Text(
      '🚀 ${recruitInfo.title}',
      style: CustomText.Title_S_18,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProjectSubtitle() {
    return Text(
      '병원관련 프로젝트 진행하려합니다!',
      style: CustomText.Body_Light_M_14.copyWith(color: CustomColor.gray_50),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/models/user_data.dart';

class ProjectHeaderSection extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;
  final UserData? authorData;

  const ProjectHeaderSection({
    Key? key,
    required this.recruitInfo,
    this.authorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectGoal(),
        SizedBox(height: 12),
        _buildProjectTitle(),
        SizedBox(height: 16),
        _buildAuthorProfile(),
      ],
    );
  }

  Widget _buildProjectGoal() {
    final goalLabel = recruitInfo.projectGoal?.label ?? '목표 미설정';
    return Text(
      '🚀 $goalLabel',
      style: CustomText.Body_Light_M_14.copyWith(
        color: Colors.white.withOpacity(0.9),
      ),
    );
  }

  Widget _buildProjectTitle() {
    return Text(
      recruitInfo.title,
      style: CustomText.Title_S_18.copyWith(color: Colors.white),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAuthorProfile() {
    return Row(
      children: [
        _buildProfileImage(),
        SizedBox(width: 8),
        _buildAuthorNickname(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(Icons.person, color: CustomColor.primary_60, size: 16),
    );
  }

  Widget _buildAuthorNickname() {
    final nickname = authorData?.nickname ?? '작구명 개발자';
    return Text(
      nickname,
      style: CustomText.Body_Light_M_14.copyWith(
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}

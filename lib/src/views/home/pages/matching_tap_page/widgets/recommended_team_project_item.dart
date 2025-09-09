import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/project_recruit_detail_page.dart';
import 'package:teamfit/src/widgets/components/shadow_box_container.dart';

class RecommendedTeamProjectItem extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const RecommendedTeamProjectItem({super.key, required this.recruitInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: ShadowBoxContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectImage(),
            SizedBox(height: 12),
            _buildProjectInfo(),
            SizedBox(height: 8),
            _buildProjectDetails(),
            SizedBox(height: 12),
            _buildTechTags(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            CustomColor.primary_60.withOpacity(0.8),
            CustomColor.primary_40.withOpacity(0.6),
          ],
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Team\nfit',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.primary_60,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text('🏆 포트폴리오 제작', style: CustomText.Body_Light_XS_12),
        ),
        SizedBox(height: 8),
        Text(
          recruitInfo.title,
          style: CustomText.Label_Heavy_M_16,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildProjectDetails() {
    return Row(
      children: [
        _buildDetailChip(Icons.location_on, '오프라인'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.people, '6명'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.schedule, '~2025.07.20'),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: CustomColor.gray_50),
        SizedBox(width: 2),
        Text(
          text,
          style: CustomText.Body_Light_XXS_11.copyWith(
            color: CustomColor.gray_50,
          ),
        ),
      ],
    );
  }

  Widget _buildTechTags() {
    final techs = ['백엔드', '디자이너', 'Next.js', 'Figma'];

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: techs.take(4).map((tech) => _buildTechTag(tech)).toList(),
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tech,
        style: CustomText.Body_Light_XXS_11.copyWith(
          color: CustomColor.gray_40,
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProjectRecruitDetailPage(recruitInfo: recruitInfo),
      ),
    );
  }
}

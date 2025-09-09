import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/project_recruit_detail_page.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProjectListItem extends StatelessWidget {
  final ProjectRecruitInfo item;
  const ProjectListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: ShadowBoxContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectImage(),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectGoal(),
                  SizedBox(height: 8),
                  _buildProjectTitle(),
                  SizedBox(height: 8),
                  _buildProjectDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: CustomColor.gray_90,
        borderRadius: BorderRadius.circular(8),
        image:
            item.projectImage != null
                ? DecorationImage(
                  image: NetworkImage(item.projectImage!),
                  fit: BoxFit.cover,
                )
                : null,
      ),
      child:
          item.projectImage == null
              ? Container(
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
                  child: Text(
                    'Team\nfit',
                    style: CustomText.Body_Heavy_XS_12.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              : null,
    );
  }

  Widget _buildProjectGoal() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),

      child: Text(
        '🏆 ${item.projectGoal?.label ?? "공모전"}',
        style: CustomText.Body_Light_XXS_11,
      ),
    );
  }

  Widget _buildProjectTitle() {
    return Text(
      item.title,
      style: CustomText.Label_Heavy_M_16,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProjectDetails() {
    return Row(
      children: [
        _buildDetailChip(Icons.location_on, item.meetingType?.label ?? '온라인'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.people, '${_getTotalRecruitCount()}명'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.schedule, item.duration?.label ?? '~2025.09.12'),
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
    final allTechs =
        item.recruitMembers
            .expand((member) => member.technologies)
            .take(3)
            .toList();

    // 샘플 데이터가 없을 경우 기본 태그 사용
    final techs = allTechs.isEmpty ? ['백엔드', '디자이너', 'Next.js'] : allTechs;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: techs.map((tech) => _buildTechTag(tech)).toList(),
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

  int _getTotalRecruitCount() {
    final count = item.recruitMembers.fold(
      0,
      (sum, member) => sum + member.count,
    );
    return count > 0 ? count : 5; // 기본값 5명
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectRecruitDetailPage(recruitInfo: item),
      ),
    );
  }
}

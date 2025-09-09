import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/project_recruit_detail_page.dart';
import 'package:teamfit/src/widgets/components/shadow_box_container.dart';

class ProjectItemBox extends StatelessWidget {
  final ProjectRecruitInfo item;
  const ProjectItemBox(this.item, {super.key});

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
            SizedBox(height: 12),
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
      height: 140,
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
                  child: Icon(Icons.groups, size: 40, color: Colors.white),
                ),
              )
              : null,
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: CustomColor.primary_95,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '🏆 ${item.projectGoal?.label ?? "포트폴리오 제작"}',
            style: CustomText.Body_Light_XS_12.copyWith(
              color: CustomColor.primary_30,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          item.title,
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
        _buildDetailChip(Icons.location_on, item.meetingType?.label ?? '오프라인'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.people, '${_getTotalRecruitCount()}명'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.schedule, item.duration?.label ?? '1개월'),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: CustomColor.gray_50),
        SizedBox(width: 4),
        Text(
          text,
          style: CustomText.Body_Light_XS_12.copyWith(
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
            .take(4)
            .toList();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...allTechs.map((tech) => _buildTechTag(tech)).toList(),
        if (item.recruitMembers.expand((m) => m.technologies).length > 4)
          _buildMoreTag(),
      ],
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tech,
        style: CustomText.Body_Light_XS_12.copyWith(color: CustomColor.gray_40),
      ),
    );
  }

  Widget _buildMoreTag() {
    final totalTechs =
        item.recruitMembers.expand((member) => member.technologies).length;
    final remainingCount = totalTechs - 4;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.primary_95,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '+$remainingCount',
        style: CustomText.Body_Light_XS_12.copyWith(
          color: CustomColor.primary_40,
        ),
      ),
    );
  }

  int _getTotalRecruitCount() {
    return item.recruitMembers.fold(0, (sum, member) => sum + member.count);
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

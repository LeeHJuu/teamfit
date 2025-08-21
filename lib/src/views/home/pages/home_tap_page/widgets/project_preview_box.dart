import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/home/pages/home_tap_page/widgets/project_preview_title.dart';
import 'package:teamfit/src/views/home/pages/home_tap_page/widgets/project_schedule_preview_box.dart';
import 'package:teamfit/src/views/home/pages/home_tap_page/widgets/team_member_progress_icon.dart';

class ProjectPreviewBox extends StatelessWidget {
  const ProjectPreviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColor.gray_20,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // 그림자 색상
            blurRadius: 10, // 블러 반경
            spreadRadius: 2, // 퍼짐 반경
            offset: Offset(0, 4), // 그림자의 위치
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _projectPreviewBoxColumn(),
      ),
    );
  }

  Column _projectPreviewBoxColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectPreviewTitle(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'home_page.member_progress'.tr(),
            style: CustomText.Title_S_18.copyWith(color: Colors.white),
          ),
        ),
        Expanded(
          child: Stack(
            children: [_projectSchedulePreviewBox(), _teamMemberPreview()],
          ),
        ),
      ],
    );
  }

  Column _projectSchedulePreviewBox() {
    return Column(
      children: [
        SizedBox(height: 25),
        Expanded(child: ProjectSchedulePreviewBox()),
      ],
    );
  }

  Positioned _teamMemberPreview() {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5, // 자식 위젯의 수에 따라 조정하세요.
          itemBuilder: (context, index) {
            return TeamMemberProgressIcon();
          },
          separatorBuilder: (context, index) => SizedBox(width: 5),
        ),
      ),
    );
  }
}

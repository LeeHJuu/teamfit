import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_preview_title.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_schedule_preview_box.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/team_member_progress_icon.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectPreviewTitle(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                '멤버 진척도',
                style: CustomText.Title_S.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 25),
                      Expanded(child: ProjectSchedulePreviewBox()),
                    ],
                  ),
                  Positioned(
                    // top: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          TeamMemberProgressIcon(),
                          TeamMemberProgressIcon(),
                          TeamMemberProgressIcon(),
                          TeamMemberProgressIcon(),
                          TeamMemberProgressIcon(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

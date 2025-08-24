import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProjectItemBox extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;
  const ProjectItemBox(this.recruitInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: Colors.green, width: 80, height: 80),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '사이드 프로젝트 백엔드/디자이너 모집',
                  style: CustomText.Subtitle_M_16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                SizedBox(height: 10),
                Text(
                  '사이드 프로젝트 백엔드/디자이너 모집',
                  style: CustomText.Body_Light_XS_12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

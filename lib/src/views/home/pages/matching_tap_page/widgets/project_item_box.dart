import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProjectItemBox extends StatelessWidget {
  final ProjectRecruitInfo item;
  const ProjectItemBox(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.projectImage != null)
            Container(color: Colors.green, width: 80, height: 80)
          else
            SizedBox(),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
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

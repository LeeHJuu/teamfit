import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_schedule_preview_box.dart';

class ProjectPreviewBox extends StatelessWidget {
  const ProjectPreviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
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
          children: [
            Text('data', style: TextStyle(color: Colors.white)),
            SizedBox(height: 100),
            Expanded(child: ProjectSchedulePreviewBox()),
          ],
        ),
      ),
    );
  }
}

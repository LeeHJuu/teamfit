import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/project_preview_info_box.dart';

class ProjectItemBox extends StatelessWidget {
  const ProjectItemBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(color: Colors.green, width: 65, height: 65),
          SizedBox(width: 10),
          ProjectPreviewInfoBox(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_preview_box.dart';
import 'package:teamfit/src/presentation/views/project/project_page.dart';

class HomeTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProjectPage()),
            );
          },
          child: ProjectPreviewBox(),
        ),
        Text('data'),
      ],
    );
  }
}

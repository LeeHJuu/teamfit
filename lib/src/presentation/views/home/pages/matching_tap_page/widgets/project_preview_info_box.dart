import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class ProjectPreviewInfoBox extends StatelessWidget {
  const ProjectPreviewInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('사이드 프로젝트 백엔드/디자이너 모집', style: CustomText.Subtitle_M_16),
        Text('사이드 프로젝트 백엔드/디자이너 모집', style: CustomText.Body_Light_M_14),
        Text('사이드 프로젝트 백엔드/디자이너 모집', style: CustomText.Body_Light_XS_12),
      ],
    );
  }
}

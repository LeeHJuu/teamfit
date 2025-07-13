import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class ProjectPreviewTitle extends StatelessWidget {
  const ProjectPreviewTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '무적팀',
            style: CustomText.Subtitle_M.copyWith(color: Colors.white),
          ),
          SizedBox(width: 20),
          Text(
            'D-30',
            style: CustomText.Body_Heavy_M.copyWith(color: Colors.white),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

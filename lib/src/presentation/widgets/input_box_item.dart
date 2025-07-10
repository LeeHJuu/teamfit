import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class InputBoxItem extends StatelessWidget {
  InputBoxItem({super.key, required this.title, required this.body});

  String title;
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: CustomText.Subtitle_M),
          SizedBox(height: 16),
          body,
        ],
      ),
    );
  }
}

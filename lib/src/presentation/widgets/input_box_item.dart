import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class InputBoxItem extends StatelessWidget {
  InputBoxItem({super.key, required this.title, required this.body});

  String title;
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class InputBoxItem extends StatelessWidget {
  InputBoxItem({super.key, required this.title, required this.body});

  String title;
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: CustomText.Label_Light_S_14),
          SizedBox(height: 8),
          body,
        ],
      ),
    );
  }
}

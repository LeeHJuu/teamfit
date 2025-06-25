import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class SignInStepTitle extends StatelessWidget {
  String title;
  SignInStepTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Text(title, style: CustomText.Headline_M),
    );
  }
}

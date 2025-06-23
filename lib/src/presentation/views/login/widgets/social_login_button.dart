import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class SocialLoginButton extends StatelessWidget {
  String title;
  IconData icon;
  MaterialColor background;
  Future<void> Function() loginFunction;

  SocialLoginButton({
    super.key,
    required this.title,
    required this.icon,
    required this.background,
    required this.loginFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 64,
      child: ElevatedButton(
        onPressed: loginFunction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Text(title, style: CustomText.Subtitle_M)],
        ),
      ),
    );
  }
}

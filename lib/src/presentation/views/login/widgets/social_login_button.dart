import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class SocialLoginButton extends StatelessWidget {
  String title;
  IconData icon;
  Color background;
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
        style: ElevatedButton.styleFrom(backgroundColor: background),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              'login.button_text'.tr(args: [title]),
              style: CustomText.Subtitle_M,
            ),
          ],
        ),
      ),
    );
  }
}

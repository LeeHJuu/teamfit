import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class SocialLoginButton extends StatelessWidget {
  String title;
  IconData icon;
  Color background;
  Color textColor;
  Future<void> Function() loginFunction;

  SocialLoginButton({
    super.key,
    required this.title,
    required this.icon,
    required this.background,
    required this.textColor,
    required this.loginFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          height: 64,
          child: ElevatedButton(
            onPressed: loginFunction,
            style: ElevatedButton.styleFrom(backgroundColor: background),
            child: Text(
              'button_text.login'.tr(args: [title]),
              style: CustomText.Subtitle_M.copyWith(color: textColor),
            ),
          ),
        ),
        Positioned(
          left: 60,
          child: SizedBox(height: 64, child: Icon(icon, color: textColor)),
        ),
      ],
    );
  }
}

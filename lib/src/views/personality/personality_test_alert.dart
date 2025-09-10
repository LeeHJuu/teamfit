import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/personality/personailty_test_page.dart';

class PersonalityTestAlert extends StatelessWidget {
  const PersonalityTestAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAlertContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAlertTitle(),
          _buildAlertDescription(),
          _buildAlertImage(),
          _buildAlertButton(context),
        ],
      ),
    );
  }

  Widget _buildAlertContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          opacity: 0.3,
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: child,
    );
  }

  Widget _buildAlertTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        'personality_test.alert.title'.tr(),
        style: CustomText.Title_M_20,
      ),
    );
  }

  Widget _buildAlertDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'personality_test.alert.description'.tr(args: ['냥냥']),
        textAlign: TextAlign.center,
        style: CustomText.Body_Light_M_14,
      ),
    );
  }

  Widget _buildAlertImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Image.asset('assets/images/main_img_w_bg.png', width: 200),
    );
  }

  Widget _buildAlertButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonailtyTestPage()),
          );
        },
        child: Text(
          'personality_test.alert.button_text'.tr(),
          style: CustomText.Subtitle_M_16,
        ),
      ),
    );
  }
}

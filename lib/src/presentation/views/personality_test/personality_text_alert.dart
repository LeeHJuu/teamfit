import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/personality_test/personailty_test_page.dart';

class PersonalityTestAlert extends StatelessWidget {
  const PersonalityTestAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CustomColor.primary_95,
        ),
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'personality_test.alert.title'.tr(),
                style: CustomText.Title_M,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'personality_test.alert.description'.tr(args: ['냥냥']),
                textAlign: TextAlign.center,
                style: CustomText.Body_Light_M,
              ),
            ),
            SizedBox(height: 200),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PersonailtyTestPage(
                            1,
                            'personality_test.default.1',
                          ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                child: Text('personality_test.alert.button_text'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

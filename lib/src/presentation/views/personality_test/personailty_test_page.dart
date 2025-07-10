import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';

class PersonailtyTestPage extends StatelessWidget {
  @override
  String label;
  PersonailtyTestPage(this.label);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomProgressBar(progress: 1),
          TestStepTitle('Q1', '$label.question'.tr()),
          Column(
            children: [
              TestAnswerButton(label: label, index: 1),
              TestAnswerButton(label: label, index: 2),
              TestAnswerButton(label: label, index: 3),
              TestAnswerButton(label: label, index: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class TestAnswerButton extends StatelessWidget {
  const TestAnswerButton({super.key, required this.label, required this.index});

  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return '$label.answers.$index'.tr() != '$label.answers.$index'
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PersonailtyTestPage('personality_test.default.2');
                    },
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$label.answers.$index'.tr(),
                  style: CustomText.Label_Light_S,
                ),
              ),
            ),
          ),
        )
        : SizedBox();
  }
}

class TestStepTitle extends StatelessWidget {
  String sub;
  String title;

  TestStepTitle(this.sub, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sub,
            style: CustomText.Title_S.copyWith(color: CustomColor.gray_10),
          ),
          Text(
            title,
            style: CustomText.Headline_S.copyWith(color: CustomColor.gray_10),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/personality_test_view_model.dart';

class TestAnswerButton extends StatefulWidget {
  const TestAnswerButton({
    super.key,
    required this.label,
    required this.index,
    required this.vm,
  });

  final String label;
  final String index;
  final PersonalityTestViewModel vm;

  @override
  _TestAnswerButtonState createState() => _TestAnswerButtonState();
}

class _TestAnswerButtonState extends State<TestAnswerButton> {
  Color buttonColor = CustomColor.gray_95;

  @override
  Widget build(BuildContext context) {
    return '${widget.label}.answers.${widget.index}'.tr() !=
            '${widget.label}.answers.${widget.index}'
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                side: BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  buttonColor = Colors.orange;
                });

                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    buttonColor = CustomColor.gray_95;
                  });
                  widget.vm.nextQuestion(context, widget.index);
                });
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.label}.answers.${widget.index}'.tr(),
                  style: CustomText.Label_Light_S_14,
                ),
              ),
            ),
          ),
        )
        : SizedBox();
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/enums.dart';
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
                  // 문자열 인덱스를 PersonalityType으로 변환
                  PersonalityType personalityType;
                  switch (widget.index) {
                    case 'D':
                      personalityType = PersonalityType.D;
                      break;
                    case 'I':
                      personalityType = PersonalityType.I;
                      break;
                    case 'S':
                      personalityType = PersonalityType.S;
                      break;
                    case 'C':
                      personalityType = PersonalityType.C;
                      break;
                    default:
                      personalityType = PersonalityType.D; // 기본값
                  }

                  widget.vm.nextQuestion(context, personalityType);
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

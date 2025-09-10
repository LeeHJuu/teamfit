import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/viewmodels/personality_test_view_model.dart';
import 'package:teamfit/src/widgets/components/custom_answer_button.dart';

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
  @override
  Widget build(BuildContext context) {
    final translatedText = '${widget.label}.answers.${widget.index}'.tr();

    // 번역이 없으면 빈 위젯 반환
    if (translatedText == '${widget.label}.answers.${widget.index}') {
      return const SizedBox();
    }

    return CustomAnswerButton(
      text: translatedText,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      onPressed: () {
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
      },
    );
  }
}

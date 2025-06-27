import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class FinishAddProjectPage extends StatelessWidget {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('팀 공고가 올라갔어요!'),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '메인으로 가기',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      ),
    );
  }
}

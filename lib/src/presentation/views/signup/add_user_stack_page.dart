import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/welcome_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserStackPage extends StatefulWidget {
  @override
  State<AddUserStackPage> createState() => _AddUserStackPageState();
}

class _AddUserStackPageState extends State<AddUserStackPage> {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('경력과 사용 기술을\n입력해주세요.'),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

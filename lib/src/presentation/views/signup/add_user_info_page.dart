import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_role_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserInfoPage extends StatefulWidget {
  @override
  State<AddUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<AddUserInfoPage> {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('간단한 추가 정보를\n입력해주세요.'),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserRolePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

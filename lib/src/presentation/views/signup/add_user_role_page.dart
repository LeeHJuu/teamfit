import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_stack_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserRolePage extends StatefulWidget {
  @override
  State<AddUserRolePage> createState() => _AddUserRolePageState();
}

class _AddUserRolePageState extends State<AddUserRolePage> {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('나의 직무 또는 전공을\n선택해주세요.'),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserStackPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

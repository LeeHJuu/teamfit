import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_goal_page.dart';
import 'package:teamfit/src/presentation/views/signup/welcome_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_dropdown_menu.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
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
          SignInStepTitle('해당 직무에서의\n경력을 알려주세요.'),
          _infomationInputBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserGoalPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infomationInputBox() {
    return Expanded(
      child: ListView(
        children: [
          InputBoxItem(
            title: '경력',
            body: CustomDropdownMenu(
              title: '경력을 선택해주세요',
              items: [
                '학생이에요',
                '1년 차 미만',
                '1년 차 이상 ~ 3년 차 이하',
                '4년 차 이상 ~ 6년 차 이하',
                '7년 차 이상 ~ 9년 차 이하',
                '10년 차 이상',
              ],
            ),
          ),
          InputBoxItem(title: '사용기술', body: _nicknameInputField()),
        ],
      ),
    );
  }

  TextField _nicknameInputField() {
    return TextField(
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        // _updateIsPossible();
      },
      decoration: InputDecoration(
        hintText: '사용 기술을 선택해주세요',
        // helperText: '서비스내에서 사용할 별명을 입력해주세요.',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_role_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserInfoPage extends StatefulWidget {
  @override
  State<AddUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<AddUserInfoPage> {
  bool _isPossible = false;
  int selectedGender = 2;

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _birthYearController = TextEditingController();
  final TextEditingController _birthMonthController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final FocusNode _birthYearFocusNode = FocusNode();
  final FocusNode _birthMonthFocusNode = FocusNode();
  final FocusNode _birthDayFocusNode = FocusNode();

  @override
  void dispose() {
    _nameTextController.dispose();
    _birthYearController.dispose();
    _birthMonthController.dispose();
    _birthDayController.dispose();
    _birthYearFocusNode.dispose();
    _birthMonthFocusNode.dispose();
    _birthDayFocusNode.dispose();
    super.dispose();
  }

  void _updateIsPossible() {
    setState(() {
      _isPossible =
          _nameTextController.text.trim().isNotEmpty &&
          _birthYearController.text.trim().isNotEmpty &&
          _birthMonthController.text.trim().isNotEmpty &&
          _birthDayController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SignInStepTitle('간단한 추가 정보를\n입력해주세요.'),
            _infomationInputBox(),
            NextStepBottomButton(
              title: '다음',
              isPossible: _isPossible,
              moveNext: () {
                // TODO: 입력한 유저 정보 저장.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserRolePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infomationInputBox() {
    return Expanded(
      child: ListView(
        children: [
          _inputBoxItem(
            '닉네임',
            TextField(
              controller: _nameTextController,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                _updateIsPossible();
              },
              decoration: InputDecoration(
                hintText: 'ex) 냥냥이',
                helperText: '서비스내에서 사용할 별명을 입력해주세요.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          _inputBoxItem(
            '성별',
            Row(
              children: [
                _genderButton(0),
                SizedBox(width: 10),
                _genderButton(1),
              ],
            ),
          ),
          _inputBoxItem(
            '생년월일',
            Row(
              children: [
                Expanded(
                  child: _birthdayInputBox(
                    '2024',
                    '년',
                    _birthYearController,
                    _birthYearFocusNode,
                    _birthMonthFocusNode,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _birthdayInputBox(
                    '1',
                    '월',
                    _birthMonthController,
                    _birthMonthFocusNode,
                    _birthDayFocusNode,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _birthdayInputBox(
                    '1',
                    '일',
                    _birthDayController,
                    _birthDayFocusNode,
                    null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _birthdayInputBox(
    String hint,
    String unit,
    TextEditingController textController,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
  ) {
    return TextField(
      controller: textController,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        _updateIsPossible();
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      textAlign: TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        hintText: hint,
        suffixText: unit,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Expanded _genderButton(int gender) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              selectedGender = gender;
            });
            _updateIsPossible();
          },
          style: OutlinedButton.styleFrom(
            backgroundColor:
                selectedGender == gender ? Colors.amber : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          child: Text(gender == 0 ? '남성' : '여성'),
        ),
      ),
    );
  }

  Widget _inputBoxItem(String title, Widget body) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: CustomText.Subtitle_M),
          SizedBox(height: 16),
          body,
        ],
      ),
    );
  }
}

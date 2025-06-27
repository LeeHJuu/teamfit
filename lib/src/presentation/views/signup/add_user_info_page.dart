import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_role_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserInfoPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends ConsumerState<AddUserInfoPage> {
  bool _isPossible = false;
  int selectedGender = 2;
  String birthdayHelperText = '';

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

  void _validateInput() {
    String yearText = _birthYearController.text;
    String monthText = _birthMonthController.text;
    String dayText = _birthDayController.text;

    // 숫자 외의 문자가 포함된 경우
    if (!_isNumeric(yearText) ||
        !_isNumeric(monthText) ||
        !_isNumeric(dayText)) {
      setState(() {
        birthdayHelperText = '숫자만 입력 가능합니다.';
      });
      return;
    }

    // 연도 유효성 검사
    int year = int.tryParse(yearText) ?? 0;
    int currentYear = DateTime.now().year;
    if (year < 1900 || year > currentYear) {
      setState(() {
        birthdayHelperText = '유효한 연도를 입력하세요.';
      });
      return;
    }

    // 월 유효성 검사
    int month = int.tryParse(monthText) ?? 0;
    if (month < 1 || month > 12) {
      setState(() {
        birthdayHelperText = '1월부터 12월까지 입력하세요.';
      });
      return;
    }

    // 일 유효성 검사
    int day = int.tryParse(dayText) ?? 0;
    if (day < 1 || day > _daysInMonth(month, year)) {
      setState(() {
        birthdayHelperText = '유효한 일을 입력하세요.';
      });
      return;
    }

    // 오늘 날짜를 넘는지 검사
    DateTime inputDate = DateTime(year, month, day);
    if (inputDate.isAfter(DateTime.now())) {
      setState(() {
        birthdayHelperText = '오늘 날짜를 넘을 수 없습니다.';
      });
    }

    setState(() {
      birthdayHelperText = '';
    });
  }

  bool _isNumeric(String value) {
    return RegExp(r'^\d+$').hasMatch(value);
  }

  int _daysInMonth(int month, int year) {
    return [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1];
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
                final loginVM = ref.read(loginViewModel.notifier);

                final nickname = _nameTextController.text.trim();
                final gender = selectedGender;
                final birthday = DateTime.parse(
                  '${_birthYearController.text.trim()}-${_birthMonthController.text.trim()}-${_birthDayController.text.trim()}',
                );

                loginVM.setUserInfo(nickname, gender, birthday);

                // 일단 여기서 계정 생성.
                loginVM.uploadUserData();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddUserRolePage()),
                // );
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
          _inputBoxItem('닉네임', _nicknameInputField()),
          _inputBoxItem('성별', _genderInputField()),
          _inputBoxItem('생년월일', _birthdayInputField()),
        ],
      ),
    );
  }

  Column _birthdayInputField() {
    return Column(
      children: [
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
        Text(
          birthdayHelperText,
          style: CustomText.Caption_M.copyWith(color: Colors.red),
        ),
      ],
    );
  }

  Row _genderInputField() {
    return Row(
      children: [_genderButton(0), SizedBox(width: 10), _genderButton(1)],
    );
  }

  TextField _nicknameInputField() {
    return TextField(
      controller: _nameTextController,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        _updateIsPossible();
      },
      decoration: InputDecoration(
        hintText: 'ex) 냥냥이',
        helperText: '서비스내에서 사용할 별명을 입력해주세요.',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
      onChanged: (value) {
        _validateInput();
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
            FocusScope.of(context).unfocus();
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

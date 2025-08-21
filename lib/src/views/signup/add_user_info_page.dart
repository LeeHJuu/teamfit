import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/signup/add_user_role_page.dart';
import 'package:teamfit/src/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/widgets/custom_select_button.dart';
import 'package:teamfit/src/widgets/custom_text_field.dart';
import 'package:teamfit/src/widgets/input_box_item.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';

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

    if (!_isNumeric(yearText) ||
        !_isNumeric(monthText) ||
        !_isNumeric(dayText)) {
      _setBirthdayHelperText('숫자만 입력 가능합니다.');
      return;
    }

    int year = int.tryParse(yearText) ?? 0;
    int currentYear = DateTime.now().year;
    if (year < 1900 || year > currentYear) {
      _setBirthdayHelperText('유효한 연도를 입력하세요.');
      return;
    }

    int month = int.tryParse(monthText) ?? 0;
    if (month < 1 || month > 12) {
      _setBirthdayHelperText('1월부터 12월까지 입력하세요.');
      return;
    }

    int day = int.tryParse(dayText) ?? 0;
    if (day < 1 || day > _daysInMonth(month, year)) {
      _setBirthdayHelperText('유효한 일을 입력하세요.');
      return;
    }

    DateTime inputDate = DateTime(year, month, day);
    if (inputDate.isAfter(DateTime.now())) {
      _setBirthdayHelperText('오늘 날짜를 넘을 수 없습니다.');
      return;
    }

    _setBirthdayHelperText('');
  }

  void _setBirthdayHelperText(String message) {
    setState(() {
      birthdayHelperText = message;
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SignInStepTitle('signin_page.user_info.title'.tr()),
            _informationInputBox(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _nextStepButton(context),
            ),
          ],
        ),
      ),
    );
  }

  NextStepBottomButton _nextStepButton(BuildContext context) {
    return NextStepBottomButton(
      title: 'button_text.next'.tr(),
      isPossible: _isPossible,
      moveNext: () {
        final loginVM = ref.read(loginViewModel.notifier);
        final nickname = _nameTextController.text.trim();
        final gender = selectedGender;
        final birthday = DateTime.parse(
          '${_birthYearController.text.trim()}-${_birthMonthController.text.trim().padLeft(2, '0')}-${_birthDayController.text.trim().padLeft(2, '0')}',
        );

        loginVM.setUserInfo(nickname, gender, birthday);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddUserRolePage()),
        );
      },
    );
  }

  Widget _informationInputBox() {
    return Expanded(
      child: ListView(
        children: [
          InputBoxItem(
            title: 'signin_page.user_info.nickname.title'.tr(),
            body: _nicknameInputField(),
          ),
          InputBoxItem(
            title: 'signin_page.user_info.gender.title'.tr(),
            body: _genderInputField(),
          ),
          InputBoxItem(
            title: 'signin_page.user_info.birth.title'.tr(),
            body: _birthdayInputField(),
          ),
        ],
      ),
    );
  }

  Column _birthdayInputField() {
    return Column(
      children: [
        Row(
          children: [
            _buildDateInput(
              '2024',
              _birthYearController,
              _birthYearFocusNode,
              _birthMonthFocusNode,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'signin_page.user_info.birth.year'.tr(),
                style: CustomText.Label_Heavy_S_14,
              ),
            ),
            SizedBox(width: 12),
            _buildDateInput(
              '1',
              _birthMonthController,
              _birthMonthFocusNode,
              _birthDayFocusNode,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'signin_page.user_info.birth.month'.tr(),
                style: CustomText.Label_Heavy_S_14,
              ),
            ),
            SizedBox(width: 12),
            _buildDateInput('1', _birthDayController, _birthDayFocusNode, null),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'signin_page.user_info.birth.date'.tr(),
                style: CustomText.Label_Heavy_S_14,
              ),
            ),
          ],
        ),
        Text(
          birthdayHelperText,
          style: CustomText.Caption_M_10.copyWith(color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildDateInput(
    String hint,
    TextEditingController controller,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
  ) {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) => FocusScope.of(context).requestFocus(nextFocusNode),
        onChanged: (value) {
          _updateIsPossible();
          _validateInput();
        },
        style: CustomText.Body_Heavy_M_14,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          isDense: true,
          hint: Text(
            hint,
            style: CustomText.Body_Light_M_14.copyWith(
              color: CustomColor.gray_80,
            ),
            textAlign: TextAlign.center,
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  controller.text.isEmpty
                      ? CustomColor.gray_80
                      : CustomColor.gray_10,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColor.primary_60),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Row _genderInputField() {
    return Row(
      children: [_genderButton(0), SizedBox(width: 10), _genderButton(1)],
    );
  }

  Widget _nicknameInputField() {
    return CustomTextField(
      textController: _nameTextController,
      hintText: 'signin_page.user_info.nickname.hint_text'.tr(),
      helperText: 'signin_page.user_info.nickname.helper_text'.tr(),
      onChange: _updateIsPossible,
    );
  }

  Widget _genderButton(int gender) {
    return Expanded(
      child: CustomSelectButton(
        title:
            gender == 0
                ? 'signin_page.user_info.gender.male'.tr()
                : 'signin_page.user_info.gender.female'.tr(),
        textAlign: 1,
        isSelected: selectedGender == gender,
        onPress: () {
          setState(() {
            selectedGender = gender;
          });
          _updateIsPossible();
        },
      ),
    );
  }
}

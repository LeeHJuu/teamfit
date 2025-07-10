import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_info_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class ServiceAgreementPage extends StatefulWidget {
  @override
  State<ServiceAgreementPage> createState() => _ServiceAgreementPageState();
}

class _ServiceAgreementPageState extends State<ServiceAgreementPage> {
  bool _isAllChecked = false;
  bool _isFirstChecked = false;
  bool _isSecondChecked = false;
  bool _isThirdChecked = false;
  bool _isFourthChecked = false;
  bool _isPossible = false;

  void _updateAllChecked() {
    setState(() {
      _isAllChecked =
          _isFirstChecked &&
          _isSecondChecked &&
          _isThirdChecked &&
          _isFourthChecked;
    });
  }

  void _updateIsPossible() {
    setState(() {
      _isPossible = _isFirstChecked && _isSecondChecked && _isThirdChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('서비스 이용 동의를\n선택해주세요.'),
          _aggrementBox(),
          Spacer(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserInfoPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _aggrementBox() {
    return Column(
      children: [
        _aggrementRow('필수 약관 전체 동의', _isAllChecked, (value) {
          setState(() {
            _isAllChecked = value!;
            _isFirstChecked = value;
            _isSecondChecked = value;
            _isThirdChecked = value;
            _isFourthChecked = value;
            _updateIsPossible();
          });
        }),
        Divider(),
        _aggrementRow('만 14세 이상입니다.', _isFirstChecked, (value) {
          setState(() {
            _isFirstChecked = value!;
            _updateIsPossible();
            _updateAllChecked();
          });
        }),
        _aggrementRow('[필수] 서비스 이용 약관', _isSecondChecked, (value) {
          setState(() {
            _isSecondChecked = value!;
            _updateIsPossible();
            _updateAllChecked();
          });
        }),
        _aggrementRow('[필수] 개인정보 처리 방침', _isThirdChecked, (value) {
          setState(() {
            _isThirdChecked = value!;
            _updateIsPossible();
            _updateAllChecked();
          });
        }),
        _aggrementRow('[선택] 마케팅 정보 수신 동의', _isFourthChecked, (value) {
          setState(() {
            _isFourthChecked = value!;
            _updateIsPossible();
            _updateAllChecked();
          });
        }),
      ],
    );
  }

  Widget _aggrementRow(
    String title,
    bool isChecked,
    ValueChanged<bool?> onChanged,
  ) {
    return CheckboxListTile(
      checkboxShape: CircleBorder(),
      checkboxScaleFactor: 1.2,
      side: BorderSide(
        width: 1.0,
        color: CustomColor.gray_80,
        style: BorderStyle.solid,
      ),

      title: Text(title),
      activeColor: CustomColor.primary_60,
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      onChanged: onChanged,
    );
  }
}

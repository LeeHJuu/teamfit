import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/home/home_page.dart';
import 'package:teamfit/src/widgets/components/next_step_bottom_button.dart';

class WelcomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
      scrolledUnderElevation: 0,),
      body: Column(
        children: [
          // SignInStepTitle의 코드를 참고하여, 텍스트를 가운데 정렬로 예외 처리
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: double.infinity,
            child: Text(
              'signin_page.welcome.title'.tr(),
              style: CustomText.Headline_S_24,
              textAlign: TextAlign.center,
            ),
          ),
          // Spacer(),
          Expanded(child: Image.asset('assets/images/welcome.png', width: 300)),
          SizedBox(height: 20),
          // _aggrementBox(),
          _nextButton(ref, context),
        ],
      ),
    );
  }

  NextStepBottomButton _nextButton(WidgetRef ref, BuildContext context) {
    return NextStepBottomButton(
      title: 'signin_page.welcome.button_text'.tr(),
      isPossible: true,
      moveNext: () async {
        final loginVM = ref.read(loginViewModel.notifier);

        // 회원가입 완료 - 모든 임시 데이터를 Firebase에 저장
        await loginVM.completeSignup();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(name: "/"),
          ),
          (route) => false, // 모든 이전 페이지를 제거하여 HomePage가 첫 페이지가 되도록 함
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class WelcomePage extends ConsumerWidget {
  bool _isPossible = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('팀Fit에 오신걸 환영해요.'),
          Spacer(),
          // _aggrementBox(),
          NextStepBottomButton(
            title: '메인으로 가기',
            isPossible: _isPossible,
            moveNext: () {
              final loginVM = ref.read(loginViewModel.notifier);
              loginVM.uploadUserData();

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

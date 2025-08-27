import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/home/home_page.dart';
import 'package:teamfit/src/views/auth/login/widgets/social_login_button.dart';
import 'package:teamfit/src/views/auth/signup/service_agreement_page.dart';

class LoginButtonColumn extends ConsumerWidget {
  const LoginButtonColumn({super.key, required this.loginVM});

  final LoginViewModel loginVM;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _kakaoLoginButton(context),
        _appleLoginButton(context),
        _googleLoginButton(context),
      ],
    );
  }

  SocialLoginButton _googleLoginButton(BuildContext context) {
    return SocialLoginButton(
      title: 'Google',
      icon: Icons.message,
      background: Colors.white,
      textColor: Colors.black,
      loginFunction: () async {
        final userCredential = await loginVM.signInWithGoogle();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          await _goToNextPage(userCredential, context);
        }
      },
    );
  }

  SocialLoginButton _appleLoginButton(BuildContext context) {
    return SocialLoginButton(
      title: 'Apple',
      icon: Icons.message,
      background: CustomColor.gray_20,
      textColor: Colors.white,
      loginFunction: () async {
        final userCredential = await loginVM.loginWighApple();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          await _goToNextPage(userCredential, context);
        }
      },
    );
  }

  SocialLoginButton _kakaoLoginButton(BuildContext context) {
    return SocialLoginButton(
      title: 'Kakao',
      icon: Icons.message,
      background: Color(0xffFCEC4E),
      textColor: Colors.black,
      loginFunction: () async {
        final userCredential = await loginVM.signInWithGoogle();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          await _goToNextPage(userCredential, context);
        }
      },
    );
  }

  Future<void> _goToNextPage(
    UserCredential userCredential,
    BuildContext context,
  ) async {
    final isUserExist = await loginVM.findUser(userCredential);

    if (!isUserExist) {
      // 신규 유저: 회원가입 시작하고 회원가입 페이지로 이동
      loginVM.startSignup(userCredential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceAgreementPage()),
      );
    } else {
      // 기존 유저: 실시간 스트림을 통해 자동으로 유저 데이터가 로드됨
      // HomePage로 이동 (loginViewModel의 스트림이 자동으로 유저 데이터 제공)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(name: '/'),
        ),
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/login/widgets/social_login_button.dart';
import 'package:teamfit/src/presentation/views/signup/service_agreement_page.dart';

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
      background: Colors.black,
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
      background: Colors.yellow,
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
      loginVM.setUserCredential(userCredential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceAgreementPage()),
      );
    } else {
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/login/login_page.dart';
import 'package:teamfit/src/presentation/views/login/widgets/social_login_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      title: 'Google로 시작하기',
      icon: Icons.message,
      background: Colors.white,
      loginFunction: () async {
        final userCredential = await loginVM.signInWithGoogle();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          //유저 데이터 파이어 베이스에 업로드
          await loginVM.uploadUserData(userCredential);

          // 로그인 처리 후 페이지 이동
          if (context.mounted) {
            await loginVM.fetchUser();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ),
            );
          }
        }
      },
    );
  }

  SocialLoginButton _appleLoginButton(BuildContext context) {
    return SocialLoginButton(
      title: 'Apple로 시작하기',
      icon: Icons.message,
      background: Colors.black,
      loginFunction: () async {
        final userCredential = await loginVM.loginWighApple();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          await loginVM.uploadUserData(userCredential);

          // 로그인 처리 후 페이지 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
    );
  }

  // SignInWithAppleButton _appleLoginButton(BuildContext context) {
  //   return SignInWithAppleButton(
  //     onPressed: () async {
  //       final userCredential = await loginVM.loginWighApple();

  //       if (userCredential == null) {
  //         print("userCredential == null");
  //         return;
  //       } else {
  //         await loginVM.uploadUserData(userCredential);

  //         // 로그인 처리 후 페이지 이동
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => LoginPage()),
  //         );
  //       }
  //     },
  //     style: SignInWithAppleButtonStyle.black,
  //     text: 'Sign in with Apple',
  //     borderRadius: BorderRadius.circular(25),
  //     height: 44,
  //   );
  // }

  SocialLoginButton _kakaoLoginButton(BuildContext context) {
    return SocialLoginButton(
      title: 'Kakao로 시작하기',
      icon: Icons.message,
      background: Colors.yellow,
      loginFunction: () async {
        final userCredential = await loginVM.signInWithGoogle();

        if (userCredential == null) {
          print("userCredential == null");
          return;
        } else {
          //유저 데이터 파이어 베이스에 업로드
          await loginVM.uploadUserData(userCredential);

          // 로그인 처리 후 페이지 이동
          if (context.mounted) {
            await loginVM.fetchUser();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ),
            );
          }
        }
      },
    );
  }
}

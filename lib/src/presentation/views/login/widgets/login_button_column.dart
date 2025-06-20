import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/login/login_page.dart';
import 'package:teamfit/src/presentation/views/login/widgets/social_login_button.dart';

class LoginButtonColumn extends ConsumerWidget {
  const LoginButtonColumn({super.key, required this.loginVM});

  final LoginViewModel loginVM;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SocialLoginButton(
          title: 'Google로 시작하기',
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
        ),
        SocialLoginButton(
          title: 'Google로 시작하기',
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
        ),
        SocialLoginButton(
          title: 'Google로 시작하기',
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
        ),
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
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
      // 신규 유저: 기본 정보만 설정하고 회원가입 페이지로 이동
      loginVM.setUserCredential(userCredential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceAgreementPage()),
      );
    } else {
      // 기존 유저: 유저 데이터를 조회하여 loginViewModel에 담기
      try {
        final userData = await loginVM.fetchUser();
        if (userData != null) {
          // 유저 데이터를 loginViewModel에 설정
          loginVM.setExistingUserData(userData);
          print('기존 유저 데이터 로드 완료: ${userData.nickname}');

          // HomePage로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
              settings: RouteSettings(name: '/'),
            ),
          );
        } else {
          // 유저 데이터 조회 실패 시 에러 처리
          print('유저 데이터 조회 실패');
          _showErrorDialog(context, '로그인 오류', '유저 정보를 불러올 수 없습니다.');
        }
      } catch (e) {
        // 에러 발생 시 에러 처리
        print('유저 데이터 조회 중 에러 발생: $e');
        _showErrorDialog(context, '로그인 오류', '로그인 중 오류가 발생했습니다.');
      }
    }
  }

  // 에러 다이얼로그 표시
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

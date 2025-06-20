import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginVM = ref.read(loginViewModel.notifier);
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  final userCredential = await loginVM.signInWithGoogle();

                  if (userCredential == null) {
                    print("userCredential == null");
                    return;
                  } else {
                    //유저 데이터 파이어 베이스에 업로드
                    await loginVM.uploadUserData(userCredential);

                    // 로그인 처리 후 페이지 이동
                    if (context.mounted) {
                      await ref.read(loginViewModel.notifier).fetchUser();

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
                child: Text('구글로그인'),
              ),
              TextButton(
                onPressed: () {
                  GoogleSignIn().signOut();
                },
                child: Text('구글로그아웃'),
              ),
            ],
          ),
          // Text(data)
        ],
      ),
    );
  }
}

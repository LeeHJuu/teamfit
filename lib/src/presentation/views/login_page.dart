import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  final userCredential = await signInWithGoogle();

                  if (userCredential == null) {
                    print("userCredential == null");
                    return;
                  } else {
                    //유저 데이터 파이어 베이스에 업로드
                    await ref
                        .read(loginViewModel.notifier)
                        .uploadUserData(userCredential);

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

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth?.idToken == null || googleAuth?.accessToken == null) {
      throw FirebaseAuthException(
        code: 'missing-credentials',
        message: 'Google authentication failed. Missing tokens.',
      );
    }
    //credential 생성
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 로그인 반환.
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

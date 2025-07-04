import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/presentation/providers/login_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends Notifier<UserData?> {
  @override
  UserData? build() {
    return null;
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

  Future<UserCredential?> loginWighApple() async {
    try {
      //애플 로그인창 띄우고 로그인
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      //OAuth 생성
      final OAuthCredential userOAuthCredential = OAuthProvider(
        'apple.com',
      ).credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      //firebase유저 생성
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        userOAuthCredential,
      );

      print('${userCredential.user!.email}');

      return userCredential;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> findUser(UserCredential userCredential) async {
    return await ref.read(userDataUsecaseProvider).findUser(userCredential);
  }

  Future<void> uploadUserData() async {
    if (state != null) {
      await ref.read(userDataUsecaseProvider).uploadUserData(state!);
    }
  }

  Future<bool> deleteUser(AuthCredential authcredential) async {
    return await ref.read(userDataUsecaseProvider).deleteUser(authcredential);
  }

  Future<void> sendUserOpinion(String text) async {
    await ref.read(userDataUsecaseProvider).sendUserOpinion(text);
  }

  Future<UserData?> fetchUser() async {
    return await ref.read(userDataUsecaseProvider).fetchUser();
  }

  void setUserCredential(UserCredential userCredential) {
    final user = userCredential.user!;
    final userData = UserData(
      uid: user.uid,
      email: user.email,
      password: null,
      nickname: '',
      projectIds: [],
      detailData: null,
    );

    state = userData;
  }

  void setUserInfo(String nickname, int gender, DateTime birthday) {
    if (state != null) {
      state = state!.copyWith(
        nickname: nickname,
        gender: gender,
        birthDate: birthday,
      );
    }
  }

  void setUserRole(String selectedRole) {
    if (state != null) {
      state = state!.copyWith(roleTag: selectedRole);
    }
  }

  void setUserGoal(String selectedGoal) {
    if (state != null) {
      state = state!.copyWith(goalTag: selectedGoal);
    }
  }
}

final loginViewModel = NotifierProvider<LoginViewModel, UserData?>(
  () => LoginViewModel(),
);

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamfit/src/config/enums.dart';
import '../models/user_data.dart';
import 'package:teamfit/src/provider.dart';
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
    return await ref.read(userServiceProvider).findUser(userCredential);
  }

  Future<void> uploadUserData() async {
    if (state != null) {
      await ref.read(userServiceProvider).uploadUserData(state!);
    }
  }

  Future<bool> deleteUser(AuthCredential authcredential) async {
    return await ref.read(userServiceProvider).deleteUser(authcredential);
  }

  Future<void> sendUserOpinion(String text) async {
    await ref.read(userServiceProvider).sendUserOpinion(text);
  }

  Future<UserData?> fetchUser() async {
    return await ref.read(userServiceProvider).fetchUser();
  }

  void setUserCredential(UserCredential userCredential) {
    final user = userCredential.user!;
    final userData = UserData(
      uid: user.uid,
      email: user.email,
      nickname: '',
      projectIds: [],
      detailData: null,
    );

    state = userData;
  }

  // 기존 유저 데이터를 설정하는 메서드
  void setExistingUserData(UserData userData) {
    state = userData;
    print('LoginViewModel: 기존 유저 데이터 설정 완료 - ${userData.nickname}');
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

  void setUserRole(UserRole role) {
    if (state != null) {
      state = state!.copyWith(role: role);
    }
  }

  void setUserStack(UserCareerLevel career, List<String> selectedStacks) {
    if (state != null) {
      state = state!.copyWith(career: career, stackTags: selectedStacks);
    }
  }

  void setUserGoal(UserGoal goal) {
    if (state != null) {
      state = state!.copyWith(goal: goal);
    }
  }

  void setUserPersonalityType() {
    if (state != null) {
      state = state!.copyWith(
        personalityScores: state!.detailData!.personalityScores,
      );
    }
  }
}

final loginViewModel = NotifierProvider<LoginViewModel, UserData?>(
  () => LoginViewModel(),
);

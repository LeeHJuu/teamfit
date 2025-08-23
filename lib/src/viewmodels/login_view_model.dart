import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamfit/src/config/enums.dart';
import '../models/user_data.dart';
import 'package:teamfit/src/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends StreamNotifier<UserData?> {
  // 회원가입 중 임시 상태 (실시간 스트림과 별도 관리)
  UserData? _tempSignupData;

  @override
  Stream<UserData?> build() {
    // Firebase Auth 상태 변화와 유저 데이터 스트림을 결합
    return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
      if (user == null) {
        return Stream.value(null);
      }

      // 로그인된 상태에서 실시간 유저 데이터 스트림 반환
      return ref.read(userServiceProvider).getUserStream();
    });
  }

  // 현재 상태 반환 (회원가입 중이면 임시 데이터, 아니면 실시간 스트림 데이터)
  UserData? get currentUserData {
    return _tempSignupData ?? state.value;
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
    final currentUser = state.value;
    if (currentUser != null) {
      await ref.read(userServiceProvider).uploadUserData(currentUser);
    }
  }

  Future<bool> deleteUser(AuthCredential authcredential) async {
    return await ref.read(userServiceProvider).deleteUser(authcredential);
  }

  Future<void> sendUserOpinion(String text) async {
    await ref.read(userServiceProvider).sendUserOpinion(text);
  }

  // 일회성 유저 데이터 조회 (기존 호환성 유지)
  Future<UserData?> fetchUser() async {
    return await ref.read(userServiceProvider).fetchUser();
  }

  // 회원가입 시작 - 임시 데이터 초기화
  void startSignup(UserCredential userCredential) {
    final user = userCredential.user!;
    _tempSignupData = UserData(
      uid: user.uid,
      email: user.email,
      nickname: '',
      projectIds: [],
      detailData: null,
    );
  }

  // 회원가입 중 임시 상태 업데이트 메서드들
  void setUserInfo(String nickname, int gender, DateTime birthday) {
    if (_tempSignupData != null) {
      _tempSignupData = _tempSignupData!.copyWith(
        nickname: nickname,
        gender: gender,
        birthDate: birthday,
      );
    }
  }

  void setUserRole(UserRole role) {
    if (_tempSignupData != null) {
      _tempSignupData = _tempSignupData!.copyWith(role: role);
    }
  }

  void setUserStack(UserCareerLevel career, List<String> selectedStacks) {
    if (_tempSignupData != null) {
      _tempSignupData = _tempSignupData!.copyWith(
        career: career,
        stackTags: selectedStacks,
      );
    }
  }

  void setUserGoal(UserGoal goal) {
    if (_tempSignupData != null) {
      _tempSignupData = _tempSignupData!.copyWith(goal: goal);
    }
  }

  void setUserPersonalityType(Map<PersonalityType, int> testResult) {
    if (_tempSignupData != null) {
      _tempSignupData = _tempSignupData!.copyWith(
        personalityScores: testResult,
      );
    }
  }

  // 회원가입 완료 - 임시 데이터를 Firebase에 저장
  Future<void> completeSignup() async {
    if (_tempSignupData != null) {
      await ref.read(userServiceProvider).uploadUserData(_tempSignupData!);
      _tempSignupData = null; // 임시 데이터 초기화
      // 이후 실시간 스트림을 통해 자동으로 상태 업데이트됨
    }
  }

  // 기존 유저용 실시간 업데이트 메서드들 (Firebase에 직접 저장하면 스트림을 통해 자동 동기화)
  Future<void> updateUserInfo(
    String nickname,
    int gender,
    DateTime birthday,
  ) async {
    final currentUser = state.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        nickname: nickname,
        gender: gender,
        birthDate: birthday,
      );
      await ref.read(userServiceProvider).uploadUserData(updatedUser);
    }
  }

  Future<void> updateUserRole(UserRole role) async {
    final currentUser = state.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(role: role);
      await ref.read(userServiceProvider).uploadUserData(updatedUser);
    }
  }

  Future<void> updateUserStack(
    UserCareerLevel career,
    List<String> selectedStacks,
  ) async {
    final currentUser = state.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        career: career,
        stackTags: selectedStacks,
      );
      await ref.read(userServiceProvider).uploadUserData(updatedUser);
    }
  }

  Future<void> updateUserGoal(UserGoal goal) async {
    final currentUser = state.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(goal: goal);
      await ref.read(userServiceProvider).uploadUserData(updatedUser);
    }
  }

  Future<void> updateUserPersonalityType(
    Map<PersonalityType, int> testResult,
  ) async {
    final currentUser = state.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(personalityScores: testResult);
      await ref.read(userServiceProvider).uploadUserData(updatedUser);
    }
  }

  // 회원가입 취소 또는 초기화
  void cancelSignup() {
    _tempSignupData = null;
  }

  // 회원가입 중인지 확인
  bool get isSigningUp {
    return _tempSignupData != null;
  }
}

final loginViewModel = StreamNotifierProvider<LoginViewModel, UserData?>(
  () => LoginViewModel(),
);

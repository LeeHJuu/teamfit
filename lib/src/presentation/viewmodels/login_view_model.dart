import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/presentation/providers/login_provider.dart';

class LoginViewModel extends Notifier<void> {
  @override
  void build() {
    // TODO: implement build
  }

  Future<void> uploadUserData(UserCredential userCredential) async {
    await ref.read(userDataUsecaseProvider).uploadUserData(userCredential);
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
}

final loginViewModel = NotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);

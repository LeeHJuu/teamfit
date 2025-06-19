import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/domain/models/user_data.dart';

abstract interface class LoginRepository {
  Future<void> uploadUserData(UserCredential userCredential);

  Future<bool> deleteUser(AuthCredential authcredential);

  Future<void> sendUserOpinion(String text);

  Future<UserData?> fetchUser();
}

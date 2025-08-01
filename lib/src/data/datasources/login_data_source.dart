import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/data/models/user_data_dto.dart';

abstract interface class LoginDataSource {
  Future<void> uploadUserData(UserDataDto userData);

  Future<bool> deleteUser(AuthCredential authcredential);

  Future<void> sendFeedback(String text);

  Future<UserDataDto?> fetchUser();

  Future<bool> findUser(UserCredential userCredential);
}

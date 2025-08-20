import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_data_dto.dart';

abstract interface class UserDataSource {
  Future<void> uploadUserData(UserDataDto userData);

  Future<bool> deleteUser(AuthCredential authcredential);

  Future<void> sendFeedback(String text);

  Future<UserDataDto?> fetchUser();

  Future<bool> findUser(UserCredential userCredential);

  Future<void> updatePersonalityType(PersonalityType personalityType);
}

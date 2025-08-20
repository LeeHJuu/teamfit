import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/domain/models/user_data.dart';

abstract interface class UserRepository {
  Future<void> uploadUserData(UserData userData);

  Future<bool> deleteUser(AuthCredential authcredential);

  Future<void> sendUserOpinion(String text);

  Future<UserData?> fetchUser();

  Future<bool> findUser(UserCredential userCredential);

  Future<void> updatePersonalityType(PersonalityType personalityType);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/datasources/user_data_source.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource);
  final UserDataSource _userDataSource;

  @override
  Future<void> uploadUserData(UserData userData) async {
    try {
      final userDataDto = userData.toDto();

      await _userDataSource.uploadUserData(userDataDto);
    } catch (e) {
      throw Exception('failed to upload user data: $e');
    }
  }

  @override
  Future<bool> deleteUser(AuthCredential authcredential) async {
    try {
      final result = await _userDataSource.deleteUser(authcredential);
      return result;
    } catch (e) {
      throw Exception('failed to delete user data: $e');
    }
  }

  @override
  Future<void> sendUserOpinion(String text) async {
    try {
      await _userDataSource.sendFeedback(text);
    } catch (e) {
      throw Exception('failed to upload feedback data: $e');
    }
  }

  @override
  Future<UserData?> fetchUser() async {
    final userDataDto = await _userDataSource.fetchUser();
    if (userDataDto != null) {
      return UserData.fromDto(userDataDto);
    } else {
      return null;
    }
  }

  @override
  Future<bool> findUser(UserCredential userCredential) async {
    try {
      final result = await _userDataSource.findUser(userCredential);
      return result;
    } catch (e) {
      throw Exception('failed to delete user data: $e');
    }
  }

  @override
  Future<void> updatePersonalityType(PersonalityType personalityType) async {
    try {
      await _userDataSource.updatePersonalityType(personalityType);
    } catch (e) {
      throw Exception('failed to update personality type: $e');
    }
  }
}

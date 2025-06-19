import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/data/datasources/login_data_source.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginDataSource);
  final LoginDataSource _loginDataSource;

  @override
  Future<void> uploadUserData(UserCredential userCredential) async {
    try {
      await _loginDataSource.uploadUserData(userCredential);
    } catch (e) {
      throw Exception('failed to upload user data: $e');
    }
  }

  @override
  Future<bool> deleteUser(AuthCredential authcredential) async {
    try {
      final result = await _loginDataSource.deleteUser(authcredential);
      return result;
    } catch (e) {
      throw Exception('failed to delete user data: $e');
    }
  }

  @override
  Future<void> sendUserOpinion(String text) async {
    try {
      await _loginDataSource.sendFeedback(text);
    } catch (e) {
      throw Exception('failed to upload feedback data: $e');
    }
  }

  @override
  Future<UserData?> fetchUser() async {
    final userDataDto = await _loginDataSource.fetchUser();
    if (userDataDto != null) {
      return UserData.fromDto(userDataDto);
    } else {
      return null;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/domain/repositories/login_repository.dart';

class UserDataUsecase {
  final LoginRepository _loginRepository;
  UserDataUsecase(this._loginRepository);

  Future<void> uploadUserData(UserData userData) async {
    await _loginRepository.uploadUserData(userData);
  }

  Future<bool> deleteUser(AuthCredential authcredential) async {
    return await _loginRepository.deleteUser(authcredential);
  }

  Future<void> sendUserOpinion(String text) async {
    await _loginRepository.sendUserOpinion(text);
  }

  Future<UserData?> fetchUser() {
    return _loginRepository.fetchUser();
  }

  Future<bool> findUser(UserCredential userCredential) async {
    return await _loginRepository.findUser(userCredential);
  }
}

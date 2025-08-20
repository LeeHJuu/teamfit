import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/domain/models/user_data.dart';
import 'package:teamfit/src/domain/repositories/user_repository.dart';

class UserDataUsecase {
  final UserRepository _userRepository;
  UserDataUsecase(this._userRepository);

  Future<void> uploadUserData(UserData userData) async {
    await _userRepository.uploadUserData(userData);
  }

  Future<bool> deleteUser(AuthCredential authcredential) async {
    return await _userRepository.deleteUser(authcredential);
  }

  Future<void> sendUserOpinion(String text) async {
    await _userRepository.sendUserOpinion(text);
  }

  Future<UserData?> fetchUser() {
    return _userRepository.fetchUser();
  }

  Future<bool> findUser(UserCredential userCredential) async {
    return await _userRepository.findUser(userCredential);
  }

  Future<void> updatePersonalityType(PersonalityType personalityType) async {
    await _userRepository.updatePersonalityType(personalityType);
  }
}

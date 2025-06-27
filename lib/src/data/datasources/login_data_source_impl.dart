import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamfit/src/data/datasources/login_data_source.dart';
import 'package:teamfit/src/data/models/user_data_dto.dart';

class LoginDataSourceImpl implements LoginDataSource {
  LoginDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  //사용자 정보 파이어베이스에 업로드
  @override
  Future<void> uploadUserData(UserDataDto userData) async {
    try {
      final userDocRef = _firestore.collection('user').doc(userData.uid);

      await userDocRef.set(userData.toJson());
    } catch (e) {
      print(e);
    }
  }

  //계정 탈퇴시 유저 정보 삭제
  @override
  Future<bool> deleteUser(AuthCredential authcredential) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) return false;

      // 재인증
      await currentUser.reauthenticateWithCredential(authcredential);
      final userRef = _firestore.collection('user').doc(currentUser.uid);

      await userRef.delete();
      await currentUser.delete();

      return true;
    } catch (e) {
      print("UserDataSourceImpl::removeUser $e");
      return false;
    }
  }

  //유저 피드백 업로드
  @override
  Future<void> sendFeedback(String text) async {
    try {
      await _firestore.collection('feedback').add({'feedback': text});
    } catch (e) {
      print(e);
    }
  }

  //user정보 가져오기
  @override
  Future<UserDataDto?> fetchUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User is not signed in.');
      }
      final userDocRef = _firestore.collection('user').doc(user.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        throw Exception('No user found with uid: ${user.uid}');
      }

      final userDataDto = UserDataDto.fromJson(
        userDoc.data() as Map<String, dynamic>,
      );
      return userDataDto;
    } catch (e) {
      throw Exception('No user found with uid: $e');
    }
  }

  @override
  Future<bool> findUser(UserCredential userCredential) async {
    final user = userCredential.user;
    final userDocRef = _firestore.collection('user').doc(user?.uid);
    final userDoc = await userDocRef.get();
    return userDoc.exists;
  }
}

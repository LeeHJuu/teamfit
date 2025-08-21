import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/enums.dart';
import '../models/user_data.dart';

class UserService {
  UserService(this._firestore);
  final FirebaseFirestore _firestore;

  // 사용자 정보 파이어베이스에 업로드
  Future<void> uploadUserData(UserData userData) async {
    try {
      final userDocRef = _firestore.collection('user').doc(userData.uid);
      await userDocRef.set(userData.toJson());
    } catch (e) {
      print(e);
      throw Exception('Failed to upload user data: $e');
    }
  }

  // 계정 탈퇴시 유저 정보 삭제
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
      print("UserService::removeUser $e");
      return false;
    }
  }

  // 유저 피드백 업로드
  Future<void> sendFeedback(String text) async {
    try {
      await _firestore.collection('feedback').add({'feedback': text});
    } catch (e) {
      print(e);
      throw Exception('Failed to send feedback: $e');
    }
  }

  // user정보 가져오기
  Future<UserData?> fetchUser() async {
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

      final userData = UserData.fromJson(
        userDoc.data() as Map<String, dynamic>,
      );
      return userData;
    } catch (e) {
      throw Exception('No user found with uid: $e');
    }
  }

  // 사용자 존재 여부 확인
  Future<bool> findUser(UserCredential userCredential) async {
    try {
      final user = userCredential.user;
      final userDocRef = _firestore.collection('user').doc(user?.uid);
      final userDoc = await userDocRef.get();
      return userDoc.exists;
    } catch (e) {
      throw Exception('Failed to find user: $e');
    }
  }

  // 성격 유형 업데이트
  Future<void> updatePersonalityType(PersonalityType personalityType) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      final userDocRef = _firestore.collection('user').doc(user.uid);
      await userDocRef.update({
        'detailData.personalityType': personalityType.name,
      });
    } catch (e) {
      print('UserService::updatePersonalityType $e');
      throw Exception('Failed to update personality type: $e');
    }
  }

  // 사용자 의견 전송 (sendFeedback의 별칭)
  Future<void> sendUserOpinion(String text) async {
    await sendFeedback(text);
  }
}

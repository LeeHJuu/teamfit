import 'package:teamfit/src/data/models/user_badge_dto.dart';
import 'package:teamfit/src/data/models/user_data_dto.dart';

class UserData {
  String uid;
  String email;
  String password;
  String nickname;
  int gender;
  DateTime birthDate;
  List<UserBadgeDto> badges;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  List<String> roleTags;
  List<String> stackTags;

  UserData({
    required this.uid,
    required this.email,
    required this.password,
    required this.nickname,
    required this.gender,
    required this.birthDate,
    required this.badges,
    required this.mannerTemperature,
    required this.attendanceRate,
    required this.completionRate,
    required this.roleTags,
    required this.stackTags,
  });

  factory UserData.fromDto(UserDataDto dto) {
    return UserData(
      uid: dto.uid,
      email: dto.email,
      password: dto.password,
      nickname: dto.nickname,
      gender: dto.gender,
      birthDate: dto.birthDate,
      badges: dto.badges,
      mannerTemperature: dto.mannerTemperature,
      attendanceRate: dto.attendanceRate,
      completionRate: dto.completionRate,
      roleTags: dto.roleTags,
      stackTags: dto.stackTags,
    );
  }

  UserDataDto toDto() {
    return UserDataDto(
      uid: uid,
      email: email,
      password: password,
      nickname: nickname,
      gender: gender,
      birthDate: birthDate,
      badges: badges,
      mannerTemperature: mannerTemperature,
      attendanceRate: attendanceRate,
      completionRate: completionRate,
      roleTags: roleTags,
      stackTags: stackTags,
    );
  }
}

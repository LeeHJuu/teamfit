import 'package:teamfit/src/data/models/user_badge_dto.dart';
import 'package:teamfit/src/data/models/user_detail_data_dto.dart';

class UserData {
  String uid;
  String? password;
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

  factory UserData.fromDto(UserDetailDataDto dto) {
    return UserData(
      uid: dto.uid,
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

  UserDetailDataDto toDto() {
    return UserDetailDataDto(
      uid: uid,
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

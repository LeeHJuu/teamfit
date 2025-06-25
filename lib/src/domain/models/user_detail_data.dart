import 'package:teamfit/src/data/models/user_badge_dto.dart';
import 'package:teamfit/src/data/models/user_detail_data_dto.dart';

class UserDetailData {
  int gender;
  DateTime birthDate;
  List<UserBadgeDto> badges;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  List<String> roleTags;
  List<String> stackTags;

  UserDetailData({
    required this.gender,
    required this.birthDate,
    required this.badges,
    required this.mannerTemperature,
    required this.attendanceRate,
    required this.completionRate,
    required this.roleTags,
    required this.stackTags,
  });

  factory UserDetailData.fromDto(UserDetailDataDto dto) {
    return UserDetailData(
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

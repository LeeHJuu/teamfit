import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_badge_dto.dart';
import 'package:teamfit/src/data/models/user_detail_data_dto.dart';

class UserDetailData {
  int gender;
  DateTime birthDate;
  List<UserBadgeDto> badges;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  String roleTag;
  String goalTag;
  UserCareerLevel career;
  List<String> stackTags;
  PersonalityType personalityType;

  UserDetailData({
    required this.gender,
    required this.birthDate,
    required this.badges,
    required this.mannerTemperature,
    required this.attendanceRate,
    required this.completionRate,
    required this.roleTag,
    required this.goalTag,
    required this.career,
    required this.stackTags,
    required this.personalityType,
  });

  factory UserDetailData.fromDto(UserDetailDataDto dto) {
    return UserDetailData(
      gender: dto.gender,
      birthDate: dto.birthDate,
      badges: dto.badges,
      mannerTemperature: dto.mannerTemperature,
      attendanceRate: dto.attendanceRate,
      completionRate: dto.completionRate,
      roleTag: dto.roleTag,
      goalTag: dto.goalTag,
      career: dto.career,
      stackTags: dto.stackTags,
      personalityType: dto.personalityType,
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
      roleTag: roleTag,
      goalTag: goalTag,
      career: career,
      stackTags: stackTags,
      personalityType: personalityType,
    );
  }

  UserDetailData copyWith({
    int? gender,
    DateTime? birthDate,
    List<UserBadgeDto>? badges,
    double? mannerTemperature,
    double? attendanceRate,
    double? completionRate,
    String? roleTag,
    String? goalTag,
    UserCareerLevel? career,
    PersonalityType? personalityType,
    List<String>? stackTags,
  }) {
    return UserDetailData(
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      badges: badges ?? List.from(this.badges),
      mannerTemperature: mannerTemperature ?? this.mannerTemperature,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      completionRate: completionRate ?? this.completionRate,
      roleTag: roleTag ?? this.roleTag,
      goalTag: goalTag ?? this.goalTag,
      career: career ?? this.career,
      personalityType: personalityType ?? this.personalityType,
      stackTags: stackTags ?? List.from(this.stackTags),
    );
  }
}

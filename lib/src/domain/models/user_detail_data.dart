import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_badge_dto.dart';
import 'package:teamfit/src/data/models/user_detail_data_dto.dart';

class UserDetailData {
  int? gender; // nullable
  DateTime? birthDate; // nullable
  List<UserBadgeDto>? badges; // nullable
  double? mannerTemperature; // nullable
  double? attendanceRate; // nullable
  double? completionRate; // nullable
  UserRole? role; // nullable, enum으로 변경
  UserGoal? goal; // nullable, enum으로 변경
  UserCareerLevel? career; // nullable
  List<String>? stackTags; // nullable
  PersonalityType? personalityType; // nullable

  UserDetailData({
    this.gender,
    this.birthDate,
    this.badges,
    this.mannerTemperature,
    this.attendanceRate,
    this.completionRate,
    this.role,
    this.goal,
    this.career,
    this.stackTags,
    this.personalityType,
  });

  factory UserDetailData.fromDto(UserDetailDataDto dto) {
    return UserDetailData(
      gender: dto.gender,
      birthDate: dto.birthDate,
      badges: dto.badges,
      mannerTemperature: dto.mannerTemperature,
      attendanceRate: dto.attendanceRate,
      completionRate: dto.completionRate,
      role: dto.role,
      goal: dto.goal,
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
      role: role,
      goal: goal,
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
    UserRole? role,
    UserGoal? goal,
    UserCareerLevel? career,
    PersonalityType? personalityType,
    List<String>? stackTags,
  }) {
    return UserDetailData(
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      badges: badges ?? this.badges,
      mannerTemperature: mannerTemperature ?? this.mannerTemperature,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      completionRate: completionRate ?? this.completionRate,
      role: role ?? this.role,
      goal: goal ?? this.goal,
      career: career ?? this.career,
      personalityType: personalityType ?? this.personalityType,
      stackTags: stackTags ?? this.stackTags,
    );
  }
}

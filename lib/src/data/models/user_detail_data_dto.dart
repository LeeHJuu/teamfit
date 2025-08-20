import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserDetailDataDto {
  int gender;
  DateTime birthDate;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  String roleTag;
  String goalTag;
  UserCareerLevel career;
  PersonalityType personalityType;
  List<String> stackTags;
  List<UserBadgeDto> badges;

  UserDetailDataDto({
    required this.gender,
    required this.birthDate,
    required this.mannerTemperature,
    required this.attendanceRate,
    required this.completionRate,
    required this.roleTag,
    required this.goalTag,
    required this.career,
    required this.stackTags,
    required this.personalityType,
    required this.badges,
  });

  factory UserDetailDataDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDataDto(
      gender: json['gender'] ?? 0,
      birthDate: DateTime.parse(json['birthDate']),
      mannerTemperature: json['mannerTemperature'] ?? 0.0,
      attendanceRate: json['attendanceRate'] ?? 0.0,
      completionRate: json['completionRate'] ?? 0.0,
      roleTag: json['roleTag'] ?? '',
      goalTag: json['goalTag'] ?? '',
      career: _parseCareerLevel(json['career']),
      stackTags: List<String>.from(json['stackTags'] ?? []),
      personalityType: _parsePersonalityType(json['personalityType']),
      badges:
          (json['badges'] as List<dynamic>? ?? [])
              .map((e) => UserBadgeDto.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'mannerTemperature': mannerTemperature,
      'attendanceRate': attendanceRate,
      'completionRate': completionRate,
      'roleTag': roleTag,
      'goalTag': goalTag,
      'career': career.key,
      'stackTags': stackTags,
      'personalityType': personalityType.key,
      'badges': badges.map((e) => e.toJson()).toList(),
    };
  }

  // Helper methods for parsing enum values
  static UserCareerLevel _parseCareerLevel(String? value) {
    if (value == null) return UserCareerLevel.student;
    try {
      return UserCareerLevel.values.firstWhere((e) => e.key == value);
    } catch (e) {
      return UserCareerLevel.student; // 기본값
    }
  }

  static PersonalityType _parsePersonalityType(String? value) {
    if (value == null) return PersonalityType.D;
    try {
      return PersonalityType.values.firstWhere((e) => e.key == value);
    } catch (e) {
      return PersonalityType.D; // 기본값
    }
  }
}

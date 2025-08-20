import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserDetailDataDto {
  int? gender; // nullable
  DateTime? birthDate; // nullable
  double? mannerTemperature; // nullable
  double? attendanceRate; // nullable
  double? completionRate; // nullable
  UserRole? role; // nullable, enum으로 변경
  UserGoal? goal; // nullable, enum으로 변경
  UserCareerLevel? career; // nullable
  PersonalityType? personalityType; // nullable
  List<String>? stackTags; // nullable
  List<UserBadgeDto>? badges; // nullable

  UserDetailDataDto({
    this.gender,
    this.birthDate,
    this.mannerTemperature,
    this.attendanceRate,
    this.completionRate,
    this.role,
    this.goal,
    this.career,
    this.personalityType,
    this.stackTags,
    this.badges,
  });

  factory UserDetailDataDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDataDto(
      gender: json['gender'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      mannerTemperature: json['mannerTemperature'],
      attendanceRate: json['attendanceRate'],
      completionRate: json['completionRate'],
      role: _parseUserRole(json['role']),
      goal: _parseUserGoal(json['goal']),
      career: _parseCareerLevel(json['career']),
      stackTags:
          json['stackTags'] != null
              ? List<String>.from(json['stackTags'])
              : null,
      personalityType: _parsePersonalityType(json['personalityType']),
      badges:
          json['badges'] != null
              ? (json['badges'] as List<dynamic>)
                  .map((e) => UserBadgeDto.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'mannerTemperature': mannerTemperature,
      'attendanceRate': attendanceRate,
      'completionRate': completionRate,
      'role': role?.name,
      'goal': goal?.name,
      'career': career?.name,
      'stackTags': stackTags,
      'personalityType': personalityType?.name,
      'badges': badges?.map((e) => e.toJson()).toList(),
    };
  }

  // Helper methods for parsing enum values
  static UserRole? _parseUserRole(String? value) {
    // nullable 반환
    if (value == null) return null;
    try {
      return UserRole.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null; // 파싱 실패 시 null 반환
    }
  }

  static UserGoal? _parseUserGoal(String? value) {
    // nullable 반환
    if (value == null) return null;
    try {
      return UserGoal.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null; // 파싱 실패 시 null 반환
    }
  }

  static UserCareerLevel? _parseCareerLevel(String? value) {
    // nullable 반환
    if (value == null) return null;
    try {
      return UserCareerLevel.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null; // 파싱 실패 시 null 반환
    }
  }

  static PersonalityType? _parsePersonalityType(String? value) {
    // nullable 반환
    if (value == null) return null;
    try {
      return PersonalityType.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null; // 파싱 실패 시 null 반환
    }
  }
}

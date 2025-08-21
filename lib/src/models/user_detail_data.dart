import '../config/enums.dart';
import 'user_badge_dto.dart';

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

  // JSON 직렬화/역직렬화 메서드
  factory UserDetailData.fromJson(Map<String, dynamic> json) {
    return UserDetailData(
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

import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserDetailDataDto {
  int gender;
  DateTime birthDate;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  String roleTag;
  String goalTag;
  String career;
  String personalityType;
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
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
      mannerTemperature: json['mannerTemperature'] ?? 0.0,
      attendanceRate: json['attendanceRate'] ?? 0.0,
      completionRate: json['completionRate'] ?? 0.0,
      roleTag: json['roleTag'] ?? '',
      goalTag: json['goalTag'] ?? '',
      career: json['career'] ?? '',
      stackTags: List<String>.from(json['stackTags'] ?? []),
      personalityType: json['personailtyType'] ?? '',
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
      'career': career,
      'stackTags': stackTags,
      'personailtyType': personalityType,
      'badges': badges.map((e) => e.toJson()).toList(),
    };
  }
}

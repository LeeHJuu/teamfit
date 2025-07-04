import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserDetailDataDto {
  int gender;
  DateTime birthDate;
  List<UserBadgeDto> badges;
  double mannerTemperature;
  double attendanceRate;
  double completionRate;
  String roleTag;
  String goalTag;
  List<String> stackTags;

  UserDetailDataDto({
    required this.gender,
    required this.birthDate,
    required this.badges,
    required this.mannerTemperature,
    required this.attendanceRate,
    required this.completionRate,
    required this.roleTag,
    required this.goalTag,
    required this.stackTags,
  });

  factory UserDetailDataDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDataDto(
      badges:
          (json['badges'] as List<dynamic>? ?? [])
              .map((e) => UserBadgeDto.fromJson(e))
              .toList(),
      mannerTemperature: json['mannerTemperature'] ?? 0.0,
      attendanceRate: json['attendanceRate'] ?? 0.0,
      completionRate: json['completionRate'] ?? 0.0,
      roleTag: json['roleTag'] ?? '',
      goalTag: json['goalTag'] ?? '',
      stackTags: List<String>.from(json['stackTags'] ?? []),
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'badges': badges.map((e) => e.toJson()).toList(),
      'mannerTemperature': mannerTemperature,
      'attendanceRate': attendanceRate,
      'completionRate': completionRate,
      'roleTag': roleTag,
      'goalTag': goalTag,
      'stackTags': stackTags,
    };
  }
}

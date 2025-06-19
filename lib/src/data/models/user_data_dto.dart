import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserDataDto {
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

  UserDataDto({
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

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return UserDataDto(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'] ?? '',
      badges:
          (json['badges'] as List<dynamic>? ?? [])
              .map((e) => UserBadgeDto.fromJson(e))
              .toList(),
      mannerTemperature: json['mannerTemperature'] ?? 0.0,
      attendanceRate: json['attendanceRate'] ?? 0.0,
      completionRate: json['completionRate'] ?? 0.0,
      roleTags: List<String>.from(json['roleTags'] ?? []),
      stackTags: List<String>.from(json['stackTags'] ?? []),
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'nickname': nickname,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'badges': badges.map((e) => e.toJson()).toList(),
      'mannerTemperature': mannerTemperature,
      'attendanceRate': attendanceRate,
      'completionRate': completionRate,
      'roleTags': roleTags,
      'stackTags': stackTags,
    };
  }
}

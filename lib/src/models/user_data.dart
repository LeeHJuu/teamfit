import '../config/enums.dart';
import 'user_detail_data.dart';
import 'user_badge_dto.dart';

class UserData {
  String uid;
  String? email;
  String? password;
  String nickname;
  List<String> projectIds;
  UserDetailData? detailData;

  UserData({
    required this.uid,
    required this.email,
    required this.password,
    required this.nickname,
    required this.projectIds,
    this.detailData,
  });

  // JSON 직렬화/역직렬화 메서드
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'] ?? '',
      projectIds: List<String>.from(json['projectIds'] ?? []),
      detailData:
          json['detailData'] != null
              ? UserDetailData.fromJson(json['detailData'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'nickname': nickname,
      'projectIds': projectIds,
      'detailData': detailData?.toJson(),
    };
  }

  UserData copyWith({
    String? uid,
    String? email,
    String? password,
    String? nickname,
    List<String>? projectIds,
    UserDetailData? detailData,
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
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      projectIds: projectIds ?? List.from(this.projectIds),
      detailData:
          detailData ??
          (this.detailData != null
              ? this.detailData!.copyWith(
                gender: gender,
                birthDate: birthDate,
                badges: badges,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityType: personalityType,
                stackTags: stackTags,
              )
              : UserDetailData(
                gender: gender,
                birthDate: birthDate,
                badges: badges,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityType: personalityType,
                stackTags: stackTags,
              )),
    );
  }
}

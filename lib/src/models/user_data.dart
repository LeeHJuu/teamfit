import '../config/enums.dart';
import 'user_detail_data.dart';

/// 사용자 기본 정보 모델
/// Firebase Authentication과 연동되는 사용자의 핵심 데이터
class UserData {
  /// Firebase Authentication의 고유 사용자 ID
  String uid;

  /// 사용자 이메일 주소 (소셜 로그인 시 제공)
  String? email;

  /// 사용자 닉네임 (화면에 표시되는 이름)
  String nickname;

  /// 참여 중인 프로젝트 ID 목록
  List<String> projectIds;

  /// 사용자 상세 정보 (프로필, 성격 테스트 결과, 평가 지표 등)
  UserDetailData? detailData;

  UserData({
    required this.uid,
    required this.email,
    required this.nickname,
    required this.projectIds,
    this.detailData,
  });

  // JSON 직렬화/역직렬화 메서드
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      email: json['email'],
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
      'nickname': nickname,
      'projectIds': projectIds,
      'detailData': detailData?.toJson(),
    };
  }

  UserData copyWith({
    String? uid,
    String? email,
    String? nickname,
    List<String>? projectIds,
    UserDetailData? detailData,
    int? gender,
    DateTime? birthDate,
    double? mannerTemperature,
    double? attendanceRate,
    double? completionRate,
    UserRole? role,
    UserGoal? goal,
    UserCareerLevel? career,
    Map<PersonalityType, int>? personalityScores,
    List<String>? stackTags,
    double? passionTemperature,
    int? mvpCount,
    double? participationRate,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      projectIds: projectIds ?? List.from(this.projectIds),
      detailData:
          detailData ??
          (this.detailData != null
              ? this.detailData!.copyWith(
                gender: gender,
                birthDate: birthDate,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityScores: personalityScores,
                stackTags: stackTags,
                passionTemperature: passionTemperature,
                mvpCount: mvpCount,
                participationRate: participationRate,
              )
              : UserDetailData(
                gender: gender,
                birthDate: birthDate,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityScores: personalityScores,
                stackTags: stackTags,
                passionTemperature: passionTemperature,
                mvpCount: mvpCount,
                participationRate: participationRate,
              )),
    );
  }
}

import '../config/enums.dart';
import 'user_detail_data.dart';

/// 사용자 기본 정보 모델
/// Firebase Authentication과 연동되는 사용자의 기본 데이터
class UserData {
  /// Firebase Authentication의 고유 사용자 ID
  String uid;

  /// 사용자 이메일 주소 (소셜 로그인 시 제공)
  String? email;

  /// 사용자 닉네임 (화면에 표시되는 이름)
  String nickname;

  /// 참여 중인 프로젝트 ID 목록
  List<String> projectIds;

  /// 사용자 상세 정보 (추가적인 프로필 데이터)
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
      uid: json['uid'] ?? '',
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
    // UserDetailData 필드들 직접 수정 가능
    int? gender,
    DateTime? birthDate,
    double? mannerTemperature,
    double? attendanceRate,
    double? completionRate,
    UserRole? role,
    UserGoal? goal,
    UserCareerLevel? career,
    List<String>? stackTags,
    Map<PersonalityType, int>? personalityScores,
    double? passionTemperature,
    int? mvpCount,
    double? participationRate,
  }) {
    // detailData가 명시적으로 전달된 경우 그것을 사용, 아니면 개별 필드들로 업데이트
    UserDetailData? newDetailData;
    if (detailData != null) {
      newDetailData = detailData;
    } else if (gender != null ||
        birthDate != null ||
        mannerTemperature != null ||
        attendanceRate != null ||
        completionRate != null ||
        role != null ||
        goal != null ||
        career != null ||
        stackTags != null ||
        personalityScores != null ||
        passionTemperature != null ||
        mvpCount != null ||
        participationRate != null) {
      // 개별 필드 중 하나라도 전달된 경우 detailData 업데이트
      newDetailData = (this.detailData ?? UserDetailData()).copyWith(
        gender: gender,
        birthDate: birthDate,
        mannerTemperature: mannerTemperature,
        attendanceRate: attendanceRate,
        completionRate: completionRate,
        role: role,
        goal: goal,
        career: career,
        stackTags: stackTags,
        personalityScores: personalityScores,
        passionTemperature: passionTemperature,
        mvpCount: mvpCount,
        participationRate: participationRate,
      );
    } else {
      newDetailData = this.detailData;
    }

    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      projectIds: projectIds ?? List.from(this.projectIds),
      detailData: newDetailData,
    );
  }

  /// 편의 Getter: 가장 높은 점수의 성격 유형 반환 (대표 성격 타입)
  PersonalityType? get dominantPersonalityType {
    return detailData?.dominantPersonalityType;
  }

  /// 편의 Getter: 사용자 역할
  UserRole? get role => detailData?.role;

  /// 편의 Getter: 사용자 목표
  UserGoal? get goal => detailData?.goal;

  /// 편의 Getter: 경력 수준
  UserCareerLevel? get career => detailData?.career;

  /// 편의 Getter: 기술 스택
  List<String>? get stackTags => detailData?.stackTags;

  /// 편의 Getter: 성격 점수
  Map<PersonalityType, int>? get personalityScores =>
      detailData?.personalityScores;

  /// 편의 Getter: MVP 횟수
  int? get mvpCount => detailData?.mvpCount;

  /// 편의 Getter: 열정온도
  double? get passionTemperature => detailData?.passionTemperature;

  /// 편의 Getter: 참여율
  double? get participationRate => detailData?.participationRate;
}

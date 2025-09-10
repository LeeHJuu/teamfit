import '../config/enums.dart';

/// 사용자 상세 정보 모델
/// 기본 인증 정보와 분리된 추가적인 사용자 정보
class UserDetailData {
  /// 성별 (0: 남성, 1: 여성, 2: 기타)
  int? gender;

  /// 생년월일
  DateTime? birthDate;

  /// 매너 온도 (기존 시스템, 추후 열정온도로 대체 예정)
  double? mannerTemperature;

  /// 출석률 (기존 시스템, 추후 참여율로 대체 예정)
  double? attendanceRate;

  /// 완료율 (프로젝트 완료 비율)
  double? completionRate;

  /// 사용자 직무/역할 (개발자, 디자이너, 기획자 등)
  UserRole? role;

  /// 사용자 목표 (포트폴리오, 창업, 취업 등)
  UserGoal? goal;

  /// 경력 수준 (신입, 주니어, 시니어 등)
  UserCareerLevel? career;

  /// 보유 기술 스택 태그 목록
  List<String>? stackTags;

  /// DISC 성격 유형별 점수 (D, I, S, C 각각의 누적 점수)
  Map<PersonalityType, int>? personalityScores;

  /// 열정온도 (프로젝트 활동 적극성 점수, 측정 방식 추후 결정)
  double? passionTemperature;

  /// MVP 선정 횟수 (프로젝트에서 Most Valuable Player로 선정된 횟수)
  int? mvpCount;

  /// 참여율 (프로젝트 활동 참여 비율)
  double? participationRate;

  UserDetailData({
    this.gender,
    this.birthDate,
    this.mannerTemperature,
    this.attendanceRate,
    this.completionRate,
    this.role,
    this.goal,
    this.career,
    this.stackTags,
    this.personalityScores,
    this.passionTemperature,
    this.mvpCount,
    this.participationRate,
  });

  // JSON 직렬화/역직렬화 메서드
  factory UserDetailData.fromJson(Map<String, dynamic> json) {
    return UserDetailData(
      gender: json['gender'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      mannerTemperature: json['mannerTemperature']?.toDouble(),
      attendanceRate: json['attendanceRate']?.toDouble(),
      completionRate: json['completionRate']?.toDouble(),
      role: _parseUserRole(json['role']),
      goal: _parseUserGoal(json['goal']),
      career: _parseCareerLevel(json['career']),
      stackTags:
          json['stackTags'] != null
              ? List<String>.from(json['stackTags'])
              : null,
      personalityScores: _parsePersonalityScores(json['personalityScores']),
      passionTemperature: json['passionTemperature']?.toDouble(),
      mvpCount: json['mvpCount'],
      participationRate: json['participationRate']?.toDouble(),
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
      'personalityScores': _personalityScoresToJson(personalityScores),
      'passionTemperature': passionTemperature,
      'mvpCount': mvpCount,
      'participationRate': participationRate,
    };
  }

  UserDetailData copyWith({
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
    return UserDetailData(
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      mannerTemperature: mannerTemperature ?? this.mannerTemperature,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      completionRate: completionRate ?? this.completionRate,
      role: role ?? this.role,
      goal: goal ?? this.goal,
      career: career ?? this.career,
      stackTags: stackTags ?? this.stackTags,
      personalityScores: personalityScores ?? this.personalityScores,
      passionTemperature: passionTemperature ?? this.passionTemperature,
      mvpCount: mvpCount ?? this.mvpCount,
      participationRate: participationRate ?? this.participationRate,
    );
  }

  // Helper methods for parsing enum values
  static UserRole? _parseUserRole(String? value) {
    if (value == null) return null;
    try {
      return UserRole.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static UserGoal? _parseUserGoal(String? value) {
    if (value == null) return null;
    try {
      return UserGoal.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static UserCareerLevel? _parseCareerLevel(String? value) {
    if (value == null) return null;
    try {
      return UserCareerLevel.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static Map<PersonalityType, int>? _parsePersonalityScores(dynamic value) {
    if (value == null) return null;
    try {
      final Map<String, dynamic> scoreMap = Map<String, dynamic>.from(value);
      final Map<PersonalityType, int> result = {};
      for (final entry in scoreMap.entries) {
        try {
          final personalityType = PersonalityType.values.firstWhere(
            (e) => e.name == entry.key,
          );
          result[personalityType] = entry.value as int;
        } catch (e) {
          continue;
        }
      }
      return result.isEmpty ? null : result;
    } catch (e) {
      return null;
    }
  }

  static Map<String, int>? _personalityScoresToJson(
    Map<PersonalityType, int>? scores,
  ) {
    if (scores == null) return null;
    final Map<String, int> result = {};
    for (final entry in scores.entries) {
      result[entry.key.name] = entry.value;
    }
    return result.isEmpty ? null : result;
  }

  /// 가장 높은 점수의 성격 유형 반환 (대표 성격 타입)
  PersonalityType? get dominantPersonalityType {
    if (personalityScores == null || personalityScores!.isEmpty) return null;
    PersonalityType? dominant;
    int maxScore = 0;
    for (final entry in personalityScores!.entries) {
      if (entry.value > maxScore) {
        maxScore = entry.value;
        dominant = entry.key;
      }
    }
    return dominant;
  }
}

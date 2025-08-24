import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/enums.dart';
import 'recruit_member.dart';

/// 프로젝트 모집 정보 모델
/// 모집글 작성 시 입력하는 프로젝트 상세 정보 (별도 컬렉션으로 분리)
class ProjectRecruitInfo {
  /// 모집 정보 고유 ID
  String id;

  /// 연관된 프로젝트 ID
  String projectId;

  /// 프로젝트 대표 이미지 (선택적)
  String? projectImage;

  /// 모집글 제목
  String title;

  /// 프로젝트 내용 소개
  String introduction;

  /// 팀 이름
  String teamName;

  /// 프로젝트 진행 기간
  ProjectDuration? duration;

  /// 회의 방식 (온라인/오프라인/혼합)
  MeetingType? meetingType;

  /// 모집하는 팀원 목록 (직무별 인원수와 기술스택)
  List<RecruitMember> recruitMembers;

  /// 선호하는 팀원의 열정온도 수준
  PassionLevel? passionLevel;

  /// 선호하는 팀원의 경력 수준
  ProjectMemberCareerLevel? careerLevel;

  /// 프로젝트 목표 (포트폴리오/창업/취업 등)
  UserGoal? projectGoal;

  /// 모집글 작성자 ID (프로젝트 리더)
  String authorId;

  /// 모집글 생성일
  DateTime createdAt;

  /// 모집글 마지막 수정일
  DateTime updatedAt;

  /// 모집 완료 여부
  bool isCompleted;

  ProjectRecruitInfo({
    required this.id,
    required this.projectId,
    this.projectImage,
    required this.title,
    required this.introduction,
    required this.teamName,
    this.duration,
    this.meetingType,
    required this.recruitMembers,
    this.passionLevel,
    this.careerLevel,
    this.projectGoal,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    this.isCompleted = false,
  });

  factory ProjectRecruitInfo.fromJson(Map<String, dynamic> json) {
    return ProjectRecruitInfo(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      projectImage: json['projectImage'],
      title: json['title'] ?? '',
      introduction: json['introduction'] ?? '',
      teamName: json['teamName'] ?? '',
      duration: _parseProjectDuration(json['duration']),
      meetingType: _parseMeetingType(json['meetingType']),
      recruitMembers:
          (json['recruitMembers'] as List?)
              ?.map((member) => RecruitMember.fromJson(member))
              .toList() ??
          [],
      passionLevel: _parsePassionLevel(json['passionLevel']),
      careerLevel: _parseCareerLevel(json['experienceLevel']),
      projectGoal: _parseUserGoal(json['projectGoal']),
      authorId: json['authorId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectImage': projectImage,
      'title': title,
      'introduction': introduction,
      'teamName': teamName,
      'duration': duration?.name,
      'meetingType': meetingType?.name,
      'recruitMembers':
          recruitMembers.map((member) => member.toJson()).toList(),
      'passionLevel': passionLevel?.name,
      'experienceLevel': careerLevel?.name,
      'projectGoal': projectGoal?.name,
      'authorId': authorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isCompleted': isCompleted,
    };
  }

  ProjectRecruitInfo copyWith({
    String? id,
    String? projectId,
    String? projectImage,
    String? title,
    String? introduction,
    String? teamName,
    ProjectDuration? duration,
    MeetingType? meetingType,
    List<RecruitMember>? recruitMembers,
    PassionLevel? passionLevel,
    ProjectMemberCareerLevel? careerLevel,
    UserGoal? projectGoal,
    String? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCompleted,
  }) {
    return ProjectRecruitInfo(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      projectImage: projectImage ?? this.projectImage,
      title: title ?? this.title,
      introduction: introduction ?? this.introduction,
      teamName: teamName ?? this.teamName,
      duration: duration ?? this.duration,
      meetingType: meetingType ?? this.meetingType,
      recruitMembers: recruitMembers ?? this.recruitMembers,
      passionLevel: passionLevel ?? this.passionLevel,
      careerLevel: careerLevel ?? this.careerLevel,
      projectGoal: projectGoal ?? this.projectGoal,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Helper methods for parsing enum values
  static ProjectDuration? _parseProjectDuration(String? value) {
    if (value == null) return null;
    try {
      return ProjectDuration.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static MeetingType? _parseMeetingType(String? value) {
    if (value == null) return null;
    try {
      return MeetingType.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static PassionLevel? _parsePassionLevel(String? value) {
    if (value == null) return null;
    try {
      return PassionLevel.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }

  static ProjectMemberCareerLevel? _parseCareerLevel(String? value) {
    if (value == null) return null;
    try {
      return ProjectMemberCareerLevel.values.firstWhere((e) => e.name == value);
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
}

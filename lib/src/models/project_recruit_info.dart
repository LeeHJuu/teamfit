import '../config/enums.dart';
import 'recruit_member.dart';

class ProjectRecruitInfo {
  String? projectImage; // 프로젝트 이미지(파일)(선택)
  String title; // 모집글 제목
  String introduction; // 프로젝트 내용 소개
  String teamName; // 팀 이름
  ProjectDuration? duration; // 프로젝트 기간
  MeetingType? meetingType; // 회의방식
  List<RecruitMember> recruitMembers; // 모집 팀원
  PassionLevel? passionLevel; // 선호 팀원 열정온도
  ProjectMemberCareerLevel? careerLevel; // 선호 팀원 경력
  UserGoal? projectGoal; // 프로젝트 목표

  ProjectRecruitInfo({
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
  });

  // JSON 직렬화/역직렬화 메서드
  factory ProjectRecruitInfo.fromJson(Map<String, dynamic> json) {
    return ProjectRecruitInfo(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  ProjectRecruitInfo copyWith({
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
  }) {
    return ProjectRecruitInfo(
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

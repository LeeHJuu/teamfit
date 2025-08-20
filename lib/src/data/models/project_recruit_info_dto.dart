import '../../config/enums.dart';
import 'recruit_member_dto.dart';

class ProjectRecruitInfoDto {
  String? projectImage; // 프로젝트 이미지(파일)(선택)
  String title; // 모집글 제목
  String introduction; // 프로젝트 내용 소개
  String teamName; // 팀 이름
  ProjectDuration? duration; // 프로젝트 기간
  MeetingType? meetingType; // 회의방식
  List<RecruitMemberDto> recruitMembers; // 모집 팀원
  PassionLevel? passionLevel; // 선호 팀원 열정온도
  ProjectMemberCareerLevel? experienceLevel; // 선호 팀원 경력
  UserGoal? projectGoal; // 프로젝트 목표

  ProjectRecruitInfoDto({
    this.projectImage,
    required this.title,
    required this.introduction,
    required this.teamName,
    this.duration,
    this.meetingType,
    required this.recruitMembers,
    this.passionLevel,
    this.experienceLevel,
    this.projectGoal,
  });

  factory ProjectRecruitInfoDto.fromJson(Map<String, dynamic> json) {
    return ProjectRecruitInfoDto(
      projectImage: json['projectImage'],
      title: json['title'] ?? '',
      introduction: json['introduction'] ?? '',
      teamName: json['teamName'] ?? '',
      duration: _parseProjectDuration(json['duration']),
      meetingType: _parseMeetingType(json['meetingType']),
      recruitMembers:
          (json['recruitMembers'] as List?)
              ?.map((member) => RecruitMemberDto.fromJson(member))
              .toList() ??
          [],
      passionLevel: _parsePassionLevel(json['passionLevel']),
      experienceLevel: _parseCareerLevel(json['experienceLevel']),
      projectGoal: _parseUserGoal(json['projectGoal']),
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
      'experienceLevel': experienceLevel?.name,
      'projectGoal': projectGoal?.name,
    };
  }
}

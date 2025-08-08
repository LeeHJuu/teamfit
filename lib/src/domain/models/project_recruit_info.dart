import 'package:teamfit/src/data/models/project_recruit_info_dto.dart';

class ProjectRecruitInfo {
  String? projectImage; // 프로젝트 이미지(파일)(선택)
  String title; // 모집글 제목
  String introduction; // 프로젝트 내용 소개
  String teamName; // 팀 이름
  ProjectDuration duration; // 프로젝트 기간
  MeetingType meetingType; // 회의방식
  List<RecruitMember> recruitMembers; // 모집 팀원
  PassionLevel passionLevel; // 선호 팀원 열정온도
  ExperienceLevel experienceLevel; // 선호 팀원 경력
  int projectGoal; // 프로젝트 목표 (1: 포트폴리오 제작, 2: 사이드 프로젝트, 3: 공모전, 4: 해커톤)

  ProjectRecruitInfo({
    this.projectImage,
    required this.title,
    required this.introduction,
    required this.teamName,
    required this.duration,
    required this.meetingType,
    required this.recruitMembers,
    required this.passionLevel,
    required this.experienceLevel,
    required this.projectGoal,
  });

  factory ProjectRecruitInfo.fromDto(ProjectRecruitInfoDto dto) {
    return ProjectRecruitInfo(
      projectImage: dto.projectImage,
      title: dto.title,
      introduction: dto.introduction,
      teamName: dto.teamName,
      duration: dto.duration,
      meetingType: dto.meetingType,
      recruitMembers: dto.recruitMembers,
      passionLevel: dto.passionLevel,
      experienceLevel: dto.experienceLevel,
      projectGoal: dto.projectGoal,
    );
  }

  ProjectRecruitInfoDto toDto() {
    return ProjectRecruitInfoDto(
      projectImage: projectImage,
      title: title,
      introduction: introduction,
      teamName: teamName,
      duration: duration,
      meetingType: meetingType,
      recruitMembers: recruitMembers,
      passionLevel: passionLevel,
      experienceLevel: experienceLevel,
      projectGoal: projectGoal,
    );
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
    ExperienceLevel? experienceLevel,
    int? projectGoal,
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
      experienceLevel: experienceLevel ?? this.experienceLevel,
      projectGoal: projectGoal ?? this.projectGoal,
    );
  }
}

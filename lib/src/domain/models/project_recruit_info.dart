import 'package:teamfit/src/config/enums.dart';
import '../../data/models/project_recruit_info_dto.dart';
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

  factory ProjectRecruitInfo.fromDto(ProjectRecruitInfoDto dto) {
    return ProjectRecruitInfo(
      projectImage: dto.projectImage,
      title: dto.title,
      introduction: dto.introduction,
      teamName: dto.teamName,
      duration: dto.duration,
      meetingType: dto.meetingType,
      recruitMembers:
          dto.recruitMembers
              .map((member) => RecruitMember.fromDto(member))
              .toList(),
      passionLevel: dto.passionLevel,
      careerLevel: dto.experienceLevel,
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
      recruitMembers: recruitMembers.map((member) => member.toDto()).toList(),
      passionLevel: passionLevel,
      experienceLevel: careerLevel,
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
}

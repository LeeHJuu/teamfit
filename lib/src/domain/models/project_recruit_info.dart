import 'package:teamfit/src/data/models/project_recruit_info_dto.dart';

class ProjectRecruitInfo {
  String projectId;
  String title;
  String introduction;
  DateTime startDate;
  DateTime endDate;
  int meetingType;
  List<int> meetingDays;
  String meetingTime;
  Map<String, int> desiredRoles;
  List<String> preferredMemberTraits;
  String additionalInfo;

  ProjectRecruitInfo({
    required this.projectId,
    required this.title,
    required this.introduction,
    required this.startDate,
    required this.endDate,
    required this.meetingType,
    required this.meetingDays,
    required this.meetingTime,
    required this.desiredRoles,
    required this.preferredMemberTraits,
    required this.additionalInfo,
  });

  factory ProjectRecruitInfo.fromDto(ProjectRecruitInfoDto dto) {
    return ProjectRecruitInfo(
      projectId: dto.projectId,
      title: dto.title,
      introduction: dto.introduction,
      startDate: dto.startDate,
      endDate: dto.endDate,
      meetingType: dto.meetingType,
      meetingDays: dto.meetingDays,
      meetingTime: dto.meetingTime,
      desiredRoles: dto.desiredRoles,
      preferredMemberTraits: dto.preferredMemberTraits,
      additionalInfo: dto.additionalInfo,
    );
  }

  ProjectRecruitInfoDto toDto() {
    return ProjectRecruitInfoDto(
      projectId: projectId,
      title: title,
      introduction: introduction,
      startDate: startDate,
      endDate: endDate,
      meetingType: meetingType,
      meetingDays: meetingDays,
      meetingTime: meetingTime,
      desiredRoles: desiredRoles,
      preferredMemberTraits: preferredMemberTraits,
      additionalInfo: additionalInfo,
    );
  }
}

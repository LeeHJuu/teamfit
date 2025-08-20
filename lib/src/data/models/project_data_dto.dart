import 'package:teamfit/src/data/models/project_member_dto.dart';
import 'package:teamfit/src/data/models/project_recruit_info_dto.dart';

class ProjectDataDto {
  ProjectRecruitInfoDto projectRecruitInfo;
  ProjectMemberDto projectMember;

  ProjectDataDto({
    required this.projectRecruitInfo,
    required this.projectMember,
  });

  factory ProjectDataDto.fromJson(Map<String, dynamic> json) {
    return ProjectDataDto(
      projectRecruitInfo: ProjectRecruitInfoDto.fromJson(
        json['projectRecruitInfo'],
      ),
      projectMember: ProjectMemberDto.fromJson(json['projectMember']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectRecruitInfo': projectRecruitInfo.toJson(),
      'projectMember': projectMember.toJson(),
    };
  }
}

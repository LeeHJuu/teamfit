import 'package:teamfit/src/models/project_recruit_info.dart';

import 'project_member_dto.dart';

class ProjectDataDto {
  ProjectRecruitInfo projectRecruitInfo;
  ProjectMemberDto projectMember;

  ProjectDataDto({
    required this.projectRecruitInfo,
    required this.projectMember,
  });

  factory ProjectDataDto.fromJson(Map<String, dynamic> json) {
    return ProjectDataDto(
      projectRecruitInfo: ProjectRecruitInfo.fromJson(
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

import 'package:teamfit/src/data/models/project_member_dto.dart';
import 'package:teamfit/src/data/models/project_recruit_info_dto.dart';

class ProjectDataDto {
  ProjectRecruitInfoDto projectRecruitInfo;
  ProjectMemberDto projectMember;

  ProjectDataDto({
    required this.projectRecruitInfo,
    required this.projectMember,
  });
}

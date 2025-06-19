import 'package:teamfit/src/data/models/member_task_dto.dart';

class ProjectMemberDto {
  String memberName;
  List<MemberTaskDto> assignedTasks;

  ProjectMemberDto({required this.memberName, required this.assignedTasks});

  factory ProjectMemberDto.fromJson(Map<String, dynamic> json) {
    return ProjectMemberDto(
      memberName: json['memberName'] ?? '',
      assignedTasks:
          (json['assignedTasks'] as List<dynamic>? ?? [])
              .map((taskJson) => MemberTaskDto.fromJson(taskJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberName': memberName,
      'assignedTasks': assignedTasks.map((t) => t.toJson()).toList(),
    };
  }
}

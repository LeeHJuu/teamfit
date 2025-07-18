import 'package:teamfit/src/data/models/member_task_dto.dart';

class ScheduleDto {
  String taskName;
  DateTime startDate;
  DateTime endDate;
  List<MemberTaskDto> memberTasks;

  ScheduleDto({
    required this.taskName,
    required this.startDate,
    required this.endDate,
    required this.memberTasks,
  });

  factory ScheduleDto.fromJson(Map<String, dynamic> json) {
    return ScheduleDto(
      taskName: json['taskName'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      memberTasks:
          (json['messages'] as List<dynamic>)
              .map((message) => MemberTaskDto.fromJson(message))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'memberTasks':
          memberTasks.map((memberTasks) => memberTasks.toJson()).toList(),
    };
  }
}

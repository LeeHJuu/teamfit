class MemberTaskDto {
  String taskName;
  DateTime deadline;
  bool isCompleted;

  MemberTaskDto({
    required this.taskName,
    required this.deadline,
    required this.isCompleted,
  });

  factory MemberTaskDto.fromJson(Map<String, dynamic> json) {
    return MemberTaskDto(
      taskName: json['taskName'] ?? '',
      deadline: DateTime.parse(json['deadline']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}

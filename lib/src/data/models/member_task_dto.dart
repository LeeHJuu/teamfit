class MemberTaskDto {
  String taskName;
  int tag;
  bool isCompleted;

  MemberTaskDto({
    required this.taskName,
    required this.tag,
    required this.isCompleted,
  });

  factory MemberTaskDto.fromJson(Map<String, dynamic> json) {
    return MemberTaskDto(
      taskName: json['taskName'] ?? '',
      tag: json['tag'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'taskName': taskName, 'tag': tag, 'isCompleted': isCompleted};
  }
}

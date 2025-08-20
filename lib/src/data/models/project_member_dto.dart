class ProjectMemberDto {
  String memberName;
  String position;
  int workingTimes;

  ProjectMemberDto({
    required this.memberName,
    required this.position,
    required this.workingTimes,
  });

  factory ProjectMemberDto.fromJson(Map<String, dynamic> json) {
    return ProjectMemberDto(
      memberName: json['memberName'] ?? '',
      position: json['position'] ?? '',
      workingTimes: json['workingTimes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberName': memberName,
      'position': position,
      'workingTimes': workingTimes,
    };
  }
}

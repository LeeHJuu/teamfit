class ProjectRecruitInfoDto {
  String projectId;
  String title;
  String introduction;
  DateTime startDate;
  DateTime endDate;
  int meetingType; // 0: 온라인, 1: 오프라인
  List<int> meetingDays; // 일(0), 월(1), 화(2), 수(3)... 등의 요일
  String meetingTime;
  Map<String, int> desiredRoles; // 예: {'디자이너': 2, '개발자': 3}
  List<String> preferredMemberTraits; // 예: ['따뜻한 성격', '1년 이상 경력']

  ProjectRecruitInfoDto({
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
  });

  factory ProjectRecruitInfoDto.fromJson(Map<String, dynamic> json) {
    return ProjectRecruitInfoDto(
      projectId: json['projectId'] ?? '',
      title: json['title'] ?? '',
      introduction: json['introduction'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      meetingType: json['collaborationType'] ?? 0,
      meetingDays: List<int>.from(json['meetingDays'] ?? []),
      meetingTime: json['meetingTime'] ?? '',
      desiredRoles: Map<String, int>.from(json['desiredRoles'] ?? {}),
      preferredMemberTraits: List<String>.from(
        json['preferredMemberTraits'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'introduction': introduction,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'collaborationType': meetingType,
      'meetingDays': meetingDays,
      'meetingTime': meetingTime,
      'desiredRoles': desiredRoles,
      'preferredMemberTraits': preferredMemberTraits,
    };
  }
}

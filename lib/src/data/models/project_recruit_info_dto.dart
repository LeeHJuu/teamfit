// 프로젝트 기간 enum
enum ProjectDuration {
  oneToSixMonths('1~6개월'),
  regular('정기');

  const ProjectDuration(this.label);
  final String label;
}

// 회의방식 enum
enum MeetingType {
  online('온라인'),
  offline('오프라인'),
  hybrid('온/오프라인'),
  discussion('협의');

  const MeetingType(this.label);
  final String label;
}

// 선호 팀원 열정온도 enum
enum PassionLevel {
  any('온도 상관없어요'),
  fiftyPlus('50도 이상'),
  ninetyPlus('90도 이상');

  const PassionLevel(this.label);
  final String label;
}

// 선호 팀원 경력 enum
enum ExperienceLevel {
  fresh('신입 환영'),
  oneToThree('1-3년차'),
  fourToSix('4-6년차'),
  sevenPlus('7년차 이상');

  const ExperienceLevel(this.label);
  final String label;
}

// 모집 팀원 정보 클래스
class RecruitMember {
  final String role; // 직무
  final int count; // 인원 수
  final List<String> technologies; // 사용 기술

  RecruitMember({
    required this.role,
    required this.count,
    required this.technologies,
  });

  factory RecruitMember.fromJson(Map<String, dynamic> json) {
    return RecruitMember(
      role: json['role'] ?? '',
      count: json['count'] ?? 0,
      technologies: List<String>.from(json['technologies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'role': role, 'count': count, 'technologies': technologies};
  }
}

class ProjectRecruitInfoDto {
  String? projectImage; // 프로젝트 이미지(파일)(선택)
  String title; // 모집글 제목
  String introduction; // 프로젝트 내용 소개
  String teamName; // 팀 이름
  ProjectDuration duration; // 프로젝트 기간
  MeetingType meetingType; // 회의방식
  List<RecruitMember> recruitMembers; // 모집 팀원
  PassionLevel passionLevel; // 선호 팀원 열정온도
  ExperienceLevel experienceLevel; // 선호 팀원 경력
  int projectGoal; // 프로젝트 목표 (1: 포트폴리오 제작, 2: 사이드 프로젝트, 3: 공모전, 4: 해커톤)

  ProjectRecruitInfoDto({
    this.projectImage,
    required this.title,
    required this.introduction,
    required this.teamName,
    required this.duration,
    required this.meetingType,
    required this.recruitMembers,
    required this.passionLevel,
    required this.experienceLevel,
    required this.projectGoal,
  });

  factory ProjectRecruitInfoDto.fromJson(Map<String, dynamic> json) {
    return ProjectRecruitInfoDto(
      projectImage: json['projectImage'],
      title: json['title'] ?? '',
      introduction: json['introduction'] ?? '',
      teamName: json['teamName'] ?? '',
      duration: ProjectDuration.values.firstWhere(
        (e) => e.name == json['duration'],
        orElse: () => ProjectDuration.oneToSixMonths,
      ),
      meetingType: MeetingType.values.firstWhere(
        (e) => e.name == json['meetingType'],
        orElse: () => MeetingType.online,
      ),
      recruitMembers:
          (json['recruitMembers'] as List?)
              ?.map((member) => RecruitMember.fromJson(member))
              .toList() ??
          [],
      passionLevel: PassionLevel.values.firstWhere(
        (e) => e.name == json['passionLevel'],
        orElse: () => PassionLevel.any,
      ),
      experienceLevel: ExperienceLevel.values.firstWhere(
        (e) => e.name == json['experienceLevel'],
        orElse: () => ExperienceLevel.fresh,
      ),
      projectGoal: json['projectGoal'] ?? 1, // 기본값: 포트폴리오 제작
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectImage': projectImage,
      'title': title,
      'introduction': introduction,
      'teamName': teamName,
      'duration': duration.name,
      'meetingType': meetingType.name,
      'recruitMembers':
          recruitMembers.map((member) => member.toJson()).toList(),
      'passionLevel': passionLevel.name,
      'experienceLevel': experienceLevel.name,
      'projectGoal': projectGoal,
    };
  }
}

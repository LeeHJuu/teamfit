// 사용자 관련 enum들
// 사용자 직무 enum
enum UserRole {
  development('개발'),
  marketing('마케팅·광고'),
  business('경영·비즈니스'),
  design('디자인'),
  ecommerce('이커머스·리테일'),
  hr('HR'),
  medical('의료·제약·바이오'),
  finance('금융'),
  media('미디어'),
  game('게임 기획·개발'),
  education('교육'),
  legal('법률·특허');

  const UserRole(this.label);
  final String label;
}

// 경력 수준 enum (UserCareer와 ExperienceLevel을 통합)
enum CareerLevel {
  student('학생이에요'),
  lessThanOne('1년 차 미만'),
  oneToThree('1년 차 이상 ~ 3년 차 이하'),
  fourToSix('4년 차 이상 ~ 6년 차 이하'),
  sevenPlus('7년 차 이상');

  const CareerLevel(this.label);
  final String label;
}

// 사용자 목표 enum
enum UserGoal {
  portfolio('포트폴리오 제작'),
  sideProject('사이드 프로젝트'),
  contest('공모전'),
  hackathon('해커톤');

  const UserGoal(this.label);
  final String label;
}

// 프로젝트 관련 enum들
// 프로젝트 기간 enum (ProjectDuration과 ProjectDurationOption을 통합)
enum ProjectDuration {
  oneMonth('1개월'),
  twoMonths('2개월'),
  threeMonths('3개월'),
  fourMonths('4개월'),
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

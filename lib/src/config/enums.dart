// 사용자 관련 enum들
// 사용자 직무 enum
enum UserRole {
  development('development', '개발'),
  marketing('marketing', '마케팅·광고'),
  business('business', '경영·비즈니스'),
  design('design', '디자인'),
  ecommerce('ecommerce', '이커머스·리테일'),
  hr('hr', 'HR'),
  medical('medical', '의료·제약·바이오'),
  finance('finance', '금융'),
  media('media', '미디어'),
  game('game', '게임 기획·개발'),
  education('education', '교육'),
  legal('legal', '법률·특허');

  const UserRole(this.key, this.label);
  final String key;
  final String label;
}

// 경력 수준 enum (UserCareer와 ExperienceLevel을 통합)
enum CareerLevel {
  student('student', '학생이에요'),
  lessThanOne('lessThanOne', '1년 차 미만'),
  oneToThree('oneToThree', '1년 차 이상 ~ 3년 차 이하'),
  fourToSix('fourToSix', '4년 차 이상 ~ 6년 차 이하'),
  sevenPlus('sevenPlus', '7년 차 이상');

  const CareerLevel(this.key, this.label);
  final String key;
  final String label;
}

// 사용자 목표 enum
enum UserGoal {
  portfolio('portfolio', '포트폴리오 제작'),
  sideProject('sideProject', '사이드 프로젝트'),
  contest('contest', '공모전'),
  hackathon('hackathon', '해커톤');

  const UserGoal(this.key, this.label);
  final String key;
  final String label;
}

// 프로젝트 관련 enum들
// 프로젝트 기간 enum (ProjectDuration과 ProjectDurationOption을 통합)
enum ProjectDuration {
  oneMonth('oneMonth', '1개월'),
  twoMonths('twoMonths', '2개월'),
  threeMonths('threeMonths', '3개월'),
  fourMonths('fourMonths', '4개월'),
  oneToSixMonths('oneToSixMonths', '1~6개월'),
  regular('regular', '정기');

  const ProjectDuration(this.key, this.label);
  final String key;
  final String label;
}

// 회의방식 enum
enum MeetingType {
  online('online', '온라인'),
  offline('offline', '오프라인'),
  hybrid('hybrid', '온/오프라인'),
  discussion('discussion', '협의');

  const MeetingType(this.key, this.label);
  final String key;
  final String label;
}

// 선호 팀원 열정온도 enum
enum PassionLevel {
  any('any', '온도 상관없어요'),
  fiftyPlus('fiftyPlus', '50도 이상'),
  ninetyPlus('ninetyPlus', '90도 이상');

  const PassionLevel(this.key, this.label);
  final String key;
  final String label;
}

// 성격 유형 enum
enum PersonalityType {
  D('D', '불꽃 리더'),
  I('I', '인싸력 만렙'),
  S('S', '평화주의자'),
  C('C', '트리플 J');

  const PersonalityType(this.key, this.label);
  final String key;
  final String label;
}

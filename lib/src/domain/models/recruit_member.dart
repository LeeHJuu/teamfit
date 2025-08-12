import '../../data/models/recruit_member_dto.dart';
import '../../config/enums.dart';

// 모집 팀원 정보 Entity 클래스
class RecruitMember {
  final UserRole role; // 직무
  final int count; // 인원 수
  final List<String> technologies; // 사용 기술

  RecruitMember({
    required this.role,
    required this.count,
    required this.technologies,
  });

  // DTO에서 Entity로 변환
  factory RecruitMember.fromDto(RecruitMemberDto dto) {
    return RecruitMember(
      role: dto.role,
      count: dto.count,
      technologies: dto.technologies,
    );
  }

  // Entity를 DTO로 변환
  RecruitMemberDto toDto() {
    return RecruitMemberDto(
      role: role,
      count: count,
      technologies: technologies,
    );
  }

  // 복사 및 수정을 위한 copyWith 메서드
  RecruitMember copyWith({
    UserRole? role,
    int? count,
    List<String>? technologies,
  }) {
    return RecruitMember(
      role: role ?? this.role,
      count: count ?? this.count,
      technologies: technologies ?? this.technologies,
    );
  }
}

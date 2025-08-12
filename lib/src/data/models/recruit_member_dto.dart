import '../../config/enums.dart';

// 모집 팀원 정보 DTO 클래스
class RecruitMemberDto {
  final UserRole role; // 직무
  final int count; // 인원 수
  final List<String> technologies; // 사용 기술

  RecruitMemberDto({
    required this.role,
    required this.count,
    required this.technologies,
  });

  factory RecruitMemberDto.fromJson(Map<String, dynamic> json) {
    return RecruitMemberDto(
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.development,
      ),
      count: json['count'] ?? 0,
      technologies: List<String>.from(json['technologies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'role': role.name, 'count': count, 'technologies': technologies};
  }
}

import '../config/enums.dart';

// 모집 팀원 정보 클래스
class RecruitMember {
  final UserRole role; // 직무
  final int count; // 인원 수
  final List<String> technologies; // 사용 기술

  RecruitMember({
    required this.role,
    required this.count,
    required this.technologies,
  });

  // JSON 직렬화/역직렬화 메서드
  factory RecruitMember.fromJson(Map<String, dynamic> json) {
    return RecruitMember(
      role: _parseUserRole(json['role']),
      count: json['count'] ?? 0,
      technologies: List<String>.from(json['technologies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'role': role.name, 'count': count, 'technologies': technologies};
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

  // Helper methods for parsing enum values
  static UserRole _parseUserRole(String? value) {
    if (value == null) return UserRole.development;
    try {
      return UserRole.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return UserRole.development; // 기본값
    }
  }
}

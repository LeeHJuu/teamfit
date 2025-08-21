import '../config/enums.dart';

/// 모집 팀원 정보 모델
/// 프로젝트에서 모집하고자 하는 직무별 팀원 정보
class RecruitMember {
  /// 모집하는 직무/역할 (개발자, 디자이너, 기획자 등)
  final UserRole role;

  /// 해당 직무의 모집 인원 수
  final int count;

  /// 요구되는 기술 스택 목록
  final List<String> technologies;

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

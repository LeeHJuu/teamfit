/// 실제 팀원 정보 모델 (MVP 투표 등에서 사용)
class TeamMember {
  /// 멤버 고유 ID
  final String id;

  /// 멤버 이름
  final String name;

  /// 멤버 역할/포지션
  final String role;

  /// 프로필 이미지 URL (선택적)
  final String? profileImage;

  TeamMember({
    required this.id,
    required this.name,
    required this.role,
    this.profileImage,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'role': role, 'profileImage': profileImage};
  }

  TeamMember copyWith({
    String? id,
    String? name,
    String? role,
    String? profileImage,
  }) {
    return TeamMember(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamMember && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class UserBadgeDto {
  String name;
  String imageUrl;
  String description;

  UserBadgeDto({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory UserBadgeDto.fromJson(Map<String, dynamic> json) {
    return UserBadgeDto(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'imageUrl': imageUrl, 'description': description};
  }
}

class UserDataDto {
  String uid;
  String email;
  List<String> projectIds;

  UserDataDto({
    required this.uid,
    required this.email,
    required this.projectIds,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return UserDataDto(
      uid: json['uid'],
      email: json['email'],
      projectIds: List<String>.from(json['projectIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'projectIds': projectIds};
  }
}

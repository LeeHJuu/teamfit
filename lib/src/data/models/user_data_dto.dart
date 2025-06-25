import 'package:teamfit/src/data/models/user_detail_data_dto.dart';

class UserDataDto {
  String uid;
  String email;
  String? password;
  String nickname;
  List<String> projectIds;
  UserDetailDataDto? detailData;

  UserDataDto({
    required this.uid,
    required this.email,
    required this.password,
    required this.nickname,
    required this.projectIds,
    required this.detailData,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return UserDataDto(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'] ?? '',
      projectIds: List<String>.from(json['projectIds'] ?? []),
      detailData: UserDetailDataDto.fromJson(json['detailData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'nickname': nickname,
      'projectIds': projectIds,
      'detailData': detailData?.toJson(),
    };
  }
}

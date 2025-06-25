import 'package:teamfit/src/data/models/user_data_dto.dart';
import 'package:teamfit/src/domain/models/user_detail_data.dart';

class UserData {
  String uid;
  String email;
  String? password;
  String nickname;
  List<String> projectIds;
  UserDetailData detailData;

  UserData({
    required this.uid,
    required this.email,
    required this.password,
    required this.nickname,
    required this.projectIds,
    required this.detailData,
  });

  factory UserData.fromDto(UserDataDto dto) {
    return UserData(
      uid: dto.uid,
      email: dto.email,
      password: dto.password,
      nickname: dto.nickname,
      projectIds: dto.projectIds,
      detailData: UserDetailData.fromDto(dto.detailData),
    );
  }

  UserDataDto toDto() {
    return UserDataDto(
      uid: uid,
      email: email,
      password: password,
      nickname: nickname,
      projectIds: projectIds,
      detailData: detailData.toDto(),
    );
  }
}

import 'package:teamfit/src/data/models/user_data_dto.dart';

class UserData {
  String uid;
  String email;
  List<String> projectIds;

  UserData({required this.uid, required this.email, required this.projectIds});

  factory UserData.fromDto(UserDataDto dto) {
    return UserData(uid: dto.uid, email: dto.email, projectIds: dto.projectIds);
  }

  UserDataDto toDto() {
    return UserDataDto(uid: uid, email: email, projectIds: projectIds);
  }
}

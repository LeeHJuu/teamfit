import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/data/models/user_data_dto.dart';
import 'package:teamfit/src/domain/models/user_detail_data.dart';
import 'package:teamfit/src/data/models/user_badge_dto.dart';

class UserData {
  String uid;
  String? email;
  String? password;
  String nickname;
  List<String> projectIds;
  UserDetailData? detailData;

  UserData({
    required this.uid,
    required this.email,
    required this.password,
    required this.nickname,
    required this.projectIds,
    this.detailData,
  });

  factory UserData.fromDto(UserDataDto dto) {
    return UserData(
      uid: dto.uid,
      email: dto.email,
      password: dto.password,
      nickname: dto.nickname,
      projectIds: dto.projectIds,
      detailData:
          dto.detailData != null
              ? UserDetailData.fromDto(dto.detailData!)
              : null,
    );
  }

  UserDataDto toDto() {
    return UserDataDto(
      uid: uid,
      email: email ?? '',
      password: password,
      nickname: nickname,
      projectIds: projectIds,
      detailData: detailData?.toDto(),
    );
  }

  UserData copyWith({
    String? uid,
    String? email,
    String? password,
    String? nickname,
    List<String>? projectIds,
    UserDetailData? detailData,
    int? gender,
    DateTime? birthDate,
    List<UserBadgeDto>? badges,
    double? mannerTemperature,
    double? attendanceRate,
    double? completionRate,
    UserRole? role,
    UserGoal? goal,
    UserCareerLevel? career,
    PersonalityType? personalityType,
    List<String>? stackTags,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      projectIds: projectIds ?? List.from(this.projectIds),
      detailData:
          detailData ??
          (this.detailData != null
              ? this.detailData!.copyWith(
                gender: gender,
                birthDate: birthDate,
                badges: badges,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityType: personalityType,
                stackTags: stackTags,
              )
              : UserDetailData(
                gender: gender,
                birthDate: birthDate,
                badges: badges,
                mannerTemperature: mannerTemperature,
                attendanceRate: attendanceRate,
                completionRate: completionRate,
                role: role,
                goal: goal,
                career: career,
                personalityType: personalityType,
                stackTags: stackTags,
              )),
    );
  }
}

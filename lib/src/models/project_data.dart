import 'package:cloud_firestore/cloud_firestore.dart';
import 'project_recruit_info.dart';
import 'schedule_data.dart';
import '../config/enums.dart';

/// 프로젝트 데이터 모델
/// 팀 프로젝트의 전반적인 정보와 관리 데이터를 포함
class ProjectData {
  /// 프로젝트 고유 ID
  String id;

  /// 프로젝트 제목
  String title;

  /// 프로젝트 설명/내용
  String description;

  /// 팀장(프로젝트 리더) 사용자 ID
  String leaderId;

  /// 현재 팀원 사용자 ID 목록
  List<String> memberIds;

  /// 프로젝트 지원자 사용자 ID 목록 (승인 대기 중)
  List<String> applicantIds;

  /// 프로젝트 모집 정보 (모집글 작성 시 입력한 정보)
  ProjectRecruitInfo recruitInfo;

  /// 프로젝트 상태 (모집중, 진행중, 완료 등)
  ProjectStatus status;

  /// 프로젝트 일정 목록 (N회차 일정들)
  List<ScheduleData> schedules;

  /// 팀원별 총 작업시간 기록 (사용자ID -> 총 작업시간)
  Map<String, Duration> workTimes;

  /// 프로젝트 생성일 (모집글 등록일)
  DateTime createdAt;

  /// 프로젝트 마지막 수정일
  DateTime updatedAt;

  ProjectData({
    required this.id,
    required this.title,
    required this.description,
    required this.leaderId,
    this.memberIds = const [],
    this.applicantIds = const [],
    required this.recruitInfo,
    this.status = ProjectStatus.recruiting,
    this.schedules = const [],
    this.workTimes = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      leaderId: json['leaderId'] ?? '',
      memberIds: List<String>.from(json['memberIds'] ?? []),
      applicantIds: List<String>.from(json['applicantIds'] ?? []),
      recruitInfo: ProjectRecruitInfo.fromJson(json['recruitInfo'] ?? {}),
      status: _parseProjectStatus(json['status']) ?? ProjectStatus.recruiting,
      schedules:
          (json['schedules'] as List?)
              ?.map((schedule) => ScheduleData.fromJson(schedule))
              .toList() ??
          [],
      workTimes: Map<String, Duration>.from(
        (json['workTimes'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, Duration(seconds: value)),
            ) ??
            {},
      ),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'leaderId': leaderId,
      'memberIds': memberIds,
      'applicantIds': applicantIds,
      'recruitInfo': recruitInfo.toJson(),
      'status': status.name,
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
      'workTimes': workTimes.map(
        (key, value) => MapEntry(key, value.inSeconds),
      ),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static ProjectStatus? _parseProjectStatus(String? value) {
    if (value == null) return null;
    try {
      return ProjectStatus.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_data.dart';

/// 프로젝트 일정 데이터 모델
/// N회차 형태의 프로젝트 일정과 관련 업무들을 관리
class ScheduleData {
  /// 일정 고유 ID
  String id;

  /// 일정 제목/설명 (예: "1회차 - 기획 및 디자인")
  String title;

  /// 일정 시작일
  DateTime startDate;

  /// 일정 종료일
  DateTime endDate;

  /// 일정 생성자 사용자 ID (팀원 누구나 생성 가능)
  String createdBy;

  /// 해당 일정에 포함된 업무(태스크) 목록
  List<TaskData> tasks;

  ScheduleData({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.createdBy,
    this.tasks = const [],
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      createdBy: json['createdBy'] ?? '',
      tasks:
          (json['tasks'] as List?)
              ?.map((task) => TaskData.fromJson(task))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'createdBy': createdBy,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }
}

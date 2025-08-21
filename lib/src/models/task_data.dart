import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/enums.dart';

/// 업무(태스크) 데이터 모델
/// 프로젝트 일정 내에서 개별 팀원에게 할당되는 구체적인 업무
class TaskData {
  /// 업무 고유 ID
  String id;

  /// 해당 업무가 속한 일정 ID
  String scheduleId;

  /// 업무 담당자 사용자 ID
  String assignedUserId;

  /// 업무 내용/설명
  String content;

  /// 업무 우선순위 (중요/보통/나중)
  TaskPriority priority;

  /// 업무 완료 여부
  bool isCompleted;

  /// 업무 생성일
  DateTime createdAt;

  TaskData({
    required this.id,
    required this.scheduleId,
    required this.assignedUserId,
    required this.content,
    required this.priority,
    this.isCompleted = false,
    required this.createdAt,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'] ?? '',
      scheduleId: json['scheduleId'] ?? '',
      assignedUserId: json['assignedUserId'] ?? '',
      content: json['content'] ?? '',
      priority: _parseTaskPriority(json['priority']) ?? TaskPriority.normal,
      isCompleted: json['isCompleted'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleId': scheduleId,
      'assignedUserId': assignedUserId,
      'content': content,
      'priority': priority.name,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static TaskPriority? _parseTaskPriority(String? value) {
    if (value == null) return null;
    try {
      return TaskPriority.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }
}

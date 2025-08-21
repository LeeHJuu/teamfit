import 'package:cloud_firestore/cloud_firestore.dart';

/// 작업시간 추적 데이터 모델
/// 팀원의 프로젝트 작업시간을 타이머로 기록하고 관리
class WorkTimeData {
  /// 작업시간 기록 고유 ID
  String id;

  /// 연결된 프로젝트 ID
  String projectId;

  /// 작업자 사용자 ID
  String userId;

  /// 누적 작업시간
  Duration duration;

  /// 현재 세션 시작 시간
  DateTime startTime;

  /// 현재 세션 종료 시간 (타이머 진행 중일 때는 null)
  DateTime? endTime;

  /// 관련된 업무(태스크) ID (선택적)
  String? taskId;

  /// 작업 내용 설명 (선택적)
  String? description;

  /// 현재 타이머 활성화 상태 여부
  bool isActive;

  /// 작업시간 기록 생성일
  DateTime createdAt;

  WorkTimeData({
    required this.id,
    required this.projectId,
    required this.userId,
    this.duration = Duration.zero,
    required this.startTime,
    this.endTime,
    this.taskId,
    this.description,
    this.isActive = false,
    required this.createdAt,
  });

  factory WorkTimeData.fromJson(Map<String, dynamic> json) {
    return WorkTimeData(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      userId: json['userId'] ?? '',
      duration: Duration(milliseconds: json['durationMillis'] ?? 0),
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime:
          json['endTime'] != null
              ? (json['endTime'] as Timestamp).toDate()
              : null,
      taskId: json['taskId'],
      description: json['description'],
      isActive: json['isActive'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'userId': userId,
      'durationMillis': duration.inMilliseconds,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': endTime != null ? Timestamp.fromDate(endTime!) : null,
      'taskId': taskId,
      'description': description,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// 작업 타이머 시작
  /// 새로운 작업 세션을 시작하고 타이머를 활성화
  WorkTimeData startTimer() {
    return WorkTimeData(
      id: id,
      projectId: projectId,
      userId: userId,
      duration: duration,
      startTime: DateTime.now(),
      endTime: null,
      taskId: taskId,
      description: description,
      isActive: true,
      createdAt: createdAt,
    );
  }

  /// 작업 타이머 종료
  /// 현재 작업 세션을 종료하고 경과 시간을 누적 시간에 추가
  WorkTimeData stopTimer() {
    final now = DateTime.now();
    final sessionDuration = now.difference(startTime);

    return WorkTimeData(
      id: id,
      projectId: projectId,
      userId: userId,
      duration: duration + sessionDuration,
      startTime: startTime,
      endTime: now,
      taskId: taskId,
      description: description,
      isActive: false,
      createdAt: createdAt,
    );
  }

  /// 현재 세션의 경과 시간 계산
  /// 타이머가 활성화되어 있을 때 현재까지의 경과 시간을 반환
  Duration get currentSessionDuration {
    if (!isActive || endTime != null) return Duration.zero;
    return DateTime.now().difference(startTime);
  }

  /// 총 작업 시간 (현재 세션 포함)
  /// 누적된 작업 시간과 현재 진행 중인 세션 시간을 합쳐서 반환
  Duration get totalDuration {
    return duration + currentSessionDuration;
  }

  /// 시간을 읽기 쉬운 형태로 포맷
  /// HH:MM:SS 형태의 문자열로 총 작업 시간을 반환
  String get formattedDuration {
    final total = totalDuration;
    final hours = total.inHours;
    final minutes = total.inMinutes.remainder(60);
    final seconds = total.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

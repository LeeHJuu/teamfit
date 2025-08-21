import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_message.dart';

/// 채팅방 유형 열거형
enum ChatType {
  team('team'), // 팀 채팅 (MVP 구현)
  personal('personal'); // 개인 채팅 (향후 업데이트 예정)

  const ChatType(this.value);
  final String value;
}

/// 채팅방 데이터 모델
/// 팀 채팅방 정보와 파일/링크 공유 설정을 관리
class ChatRoom {
  /// 채팅방 고유 ID
  String id;

  /// 연결된 프로젝트 ID
  String projectId;

  /// 채팅방 참여자 사용자 ID 목록
  List<String> memberIds;

  /// 채팅방 유형 (팀/개인)
  ChatType chatType;

  /// 파일 공유 허용 여부
  bool fileSharing;

  /// 링크 공유 허용 여부
  bool linkSharing;

  /// 채팅방 생성일
  DateTime createdAt;

  /// 마지막 메시지 정보
  ChatMessage? lastMessage;

  ChatRoom({
    required this.id,
    required this.projectId,
    required this.memberIds,
    this.chatType = ChatType.team,
    this.fileSharing = true,
    this.linkSharing = true,
    required this.createdAt,
    this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      memberIds: List<String>.from(json['memberIds'] ?? []),
      chatType: _parseChatType(json['chatType']) ?? ChatType.team,
      fileSharing: json['fileSharing'] ?? true,
      linkSharing: json['linkSharing'] ?? true,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      lastMessage:
          json['lastMessage'] != null
              ? ChatMessage.fromJson(json['lastMessage'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'memberIds': memberIds,
      'chatType': chatType.value,
      'fileSharing': fileSharing,
      'linkSharing': linkSharing,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMessage': lastMessage?.toJson(),
    };
  }

  static ChatType? _parseChatType(String? value) {
    if (value == null) return null;
    try {
      return ChatType.values.firstWhere((e) => e.value == value);
    } catch (e) {
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

/// 메시지 유형 열거형
enum MessageType {
  text('text'), // 텍스트 메시지
  file('file'), // 파일 공유 메시지
  link('link'); // 링크 공유 메시지

  const MessageType(this.value);
  final String value;
}

/// 채팅 메시지 데이터 모델
/// 개별 채팅 메시지의 정보를 관리
class ChatMessage {
  /// 메시지 고유 ID
  String id;

  /// 메시지 내용 (텍스트, 파일명, URL 등)
  String content;

  /// 메시지 발송자 사용자 ID
  String senderId;

  /// 메시지 유형 (텍스트/파일/링크)
  MessageType type;

  /// 메시지 발송 시간
  DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.type,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      senderId: json['senderId'] ?? '',
      type: _parseMessageType(json['type']) ?? MessageType.text,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'type': type.value,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  static MessageType? _parseMessageType(String? value) {
    if (value == null) return null;
    try {
      return MessageType.values.firstWhere((e) => e.value == value);
    } catch (e) {
      return null;
    }
  }
}

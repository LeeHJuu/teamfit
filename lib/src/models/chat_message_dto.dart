class ChatMessageDto {
  String senderUid;
  DateTime timestamp;
  String content;

  ChatMessageDto({
    required this.senderUid,
    required this.timestamp,
    required this.content,
  });

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      senderUid: json['senderUid'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'timestamp': timestamp.toIso8601String(),
      'content': content,
    };
  }
}

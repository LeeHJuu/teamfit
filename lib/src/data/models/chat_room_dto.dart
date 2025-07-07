import 'package:teamfit/src/data/models/chat_message_dto.dart';

class ChatRoomDto {
  List<String> memberIds;
  List<ChatMessageDto> messages;

  ChatRoomDto({required this.memberIds, required this.messages});

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) {
    return ChatRoomDto(
      memberIds: List<String>.from(json['memberIds'] ?? []),
      messages:
          (json['messages'] as List<dynamic>)
              .map((message) => ChatMessageDto.fromJson(message))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberIds': memberIds,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

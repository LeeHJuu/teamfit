import 'package:flutter/material.dart';
import 'package:teamfit/src/models/chat_message.dart';
import 'package:teamfit/src/models/user_data.dart';
import 'package:teamfit/src/views/project/detail/chat/widgets/chat_message_item.dart';
import 'package:teamfit/src/views/project/detail/chat/widgets/chat_date_divider.dart';

class ChatMessageList extends StatefulWidget {
  final List<ChatMessage> messages;
  final Map<String, UserData> users;
  final String currentUserId;

  const ChatMessageList({
    Key? key,
    required this.messages,
    required this.users,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ChatMessageListState createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(ChatMessageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 새 메시지가 추가되면 자동으로 스크롤
    if (widget.messages.length > oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _getItemCount(),
        itemBuilder: (context, index) => _buildItem(index),
      ),
    );
  }

  int _getItemCount() {
    if (widget.messages.isEmpty) return 1; // 날짜 헤더만
    return widget.messages.length + 1; // 메시지들 + 날짜 헤더
  }

  Widget _buildItem(int index) {
    if (index == 0) {
      // 첫 번째 아이템은 날짜 표시
      return ChatDateDivider(date: DateTime.now());
    }

    final messageIndex = index - 1;
    final message = widget.messages[messageIndex];
    final userData = widget.users[message.senderId];
    final isMe = message.senderId == widget.currentUserId;

    // 이전 메시지 확인 (첫 번째 메시지가 아닌 경우)
    ChatMessage? previousMessage;
    if (messageIndex > 0) {
      previousMessage = widget.messages[messageIndex - 1];
    }

    return ChatMessageItem(
      message: message,
      userData: userData,
      isMe: isMe,
      previousMessage: previousMessage, // 이전 메시지 전달
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

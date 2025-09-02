import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/chat_message.dart';
import 'package:teamfit/src/models/user_data.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessage message;
  final UserData? userData;
  final bool isMe;
  final ChatMessage? previousMessage; // 이전 메시지 추가

  const ChatMessageItem({
    Key? key,
    required this.message,
    this.userData,
    required this.isMe,
    this.previousMessage, // 이전 메시지 파라미터 추가
  }) : super(key: key);

  // 연속된 메시지인지 확인하는 메서드
  bool get isConsecutiveMessage {
    if (previousMessage == null) return false;

    // 이전 메시지가 시스템 메시지가 아니고, 같은 사용자가 보낸 메시지인 경우
    return previousMessage!.senderId.isNotEmpty &&
        previousMessage!.senderId == message.senderId;
  }

  @override
  Widget build(BuildContext context) {
    // senderId가 빈 값이면 시스템 메시지로 처리
    if (message.senderId.isEmpty) {
      return _buildSystemMessage();
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isConsecutiveMessage ? 2 : 4,
      ), // 연속 메시지는 간격 줄임
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            _buildOtherUserMessage(),
          ] else ...[
            _buildMyMessage(context),
          ],
        ],
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          message.content,
          style: CustomText.Body_Light_S_13.copyWith(
            color: CustomColor.gray_50,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildOtherUserMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 프로필 이미지 - 연속 메시지인 경우 투명하게 처리
        Container(
          width: 36,
          height: 36,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color:
                isConsecutiveMessage ? Colors.transparent : CustomColor.gray_80,
            shape: BoxShape.circle,
          ),
          child:
              isConsecutiveMessage
                  ? null
                  : Icon(Icons.person, color: Colors.white, size: 20),
        ),
        // 이름과 메시지
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 연속 메시지가 아닌 경우에만 이름 표시
              if (!isConsecutiveMessage) ...[
                Text(
                  userData?.nickname ?? '알 수 없음',
                  style: CustomText.Body_Heavy_S_13,
                ),
                SizedBox(height: 4),
              ],
              _buildMessageBubble(
                color: CustomColor.gray_90,
                textColor: CustomColor.gray_10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMyMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildMessageBubble(
          color: CustomColor.primary_90,
          textColor: CustomColor.gray_10,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
      ],
    );
  }

  Widget _buildMessageBubble({
    required Color color,
    required Color textColor,
    double? maxWidth,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            isMe
                ? BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  // bottomRight는 제외 (0으로 설정)
                )
                : BorderRadius.only(
                  // topLeft는 제외 (0으로 설정)
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
      ),
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: Text(
        message.content,
        style: CustomText.Body_Light_M_14.copyWith(color: textColor),
      ),
    );
  }
}

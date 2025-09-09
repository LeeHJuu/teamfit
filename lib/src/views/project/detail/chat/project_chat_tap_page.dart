import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/chat_view_model.dart';
import 'package:teamfit/src/views/project/detail/chat/widgets/chat_message_list.dart';
import 'package:teamfit/src/views/project/detail/chat/widgets/chat_input_field.dart';
import 'package:teamfit/src/widgets/components/rounded_container.dart';

class ProjectChatTapPage extends ConsumerWidget {
  final String projectId;

  const ProjectChatTapPage({Key? key, required this.projectId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatViewModelProvider(projectId));
    final chatViewModel = ref.read(chatViewModelProvider(projectId).notifier);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: CustomColor.primary_60,
      body: RoundedContainer(
        background: Colors.white,
        child: Column(
          children: [
            if (chatState.isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.primary_60,
                  ),
                ),
              )
            else if (chatState.error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('오류가 발생했습니다', style: CustomText.Body_Heavy_M_14),
                      SizedBox(height: 8),
                      Text(
                        chatState.error!,
                        style: CustomText.Body_Light_S_13.copyWith(
                          color: CustomColor.gray_50,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              ChatMessageList(
                messages: chatState.messages,
                users: chatState.users,
                currentUserId: chatViewModel.getCurrentUserId(),
              ),
              ChatInputField(onSendMessage: chatViewModel.sendMessage),
            ],
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: CustomColor.primary_60,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        '무적팀 채팅',
        style: CustomText.Title_S_18.copyWith(color: Colors.white),
      ),
      centerTitle: false,
    );
  }
}

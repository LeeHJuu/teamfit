import 'package:flutter/material.dart';
import '../../../../../models/user_data.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/theme/custom_text.dart';

class TeamMemberList extends StatelessWidget {
  final List<UserData> members;
  final Function(UserData) onMemberTap;
  final VoidCallback onInviteTap;

  const TeamMemberList({
    Key? key,
    required this.members,
    required this.onMemberTap,
    required this.onInviteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: members.length + 1, // 멤버 수 + 초대 버튼
      itemBuilder: (context, index) {
        if (index == members.length) {
          // 마지막 아이템은 초대 버튼
          return _buildInviteButton();
        }

        final member = members[index];
        return _buildMemberItem(member);
      },
    );
  }

  Widget _buildMemberItem(UserData member) {
    final role = member.role?.label ?? '역할 미정';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () => onMemberTap(member),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: CustomColor.gray_90,
              child: Icon(Icons.person, color: CustomColor.gray_60, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: CustomText.Body_Light_M_14.copyWith(
                      color: CustomColor.gray_60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    member.nickname,
                    style: CustomText.Label_Light_M_16.copyWith(
                      color: CustomColor.gray_10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 32),
      child: OutlinedButton(
        onPressed: onInviteTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: CustomColor.gray_80),
          foregroundColor: CustomColor.gray_60,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mail_outline, size: 20),
            const SizedBox(width: 8),
            Text('초대하기', style: CustomText.Body_Light_S_13),
          ],
        ),
      ),
    );
  }
}

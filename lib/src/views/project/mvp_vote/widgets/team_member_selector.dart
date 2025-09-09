import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import '../mvp_vote_page.dart';

class TeamMemberSelector extends StatelessWidget {
  final List<TeamMember> members;
  final String? selectedMemberId;
  final Function(String) onMemberSelected;

  const TeamMemberSelector({
    Key? key,
    required this.members,
    required this.selectedMemberId,
    required this.onMemberSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          members
              .map(
                (member) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: TeamMemberCard(
                      member: member,
                      isSelected: selectedMemberId == member.id,
                      onTap: () => onMemberSelected(member.id),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  final bool isSelected;
  final VoidCallback onTap;

  const TeamMemberCard({
    Key? key,
    required this.member,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [_buildProfileImage(), SizedBox(height: 8), _buildName()],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: CustomColor.gray_90,
        shape: BoxShape.circle,
        border:
            isSelected
                ? Border.all(color: CustomColor.primary_60, width: 3)
                : null,
      ),
      child: Icon(
        Icons.person,
        color: isSelected ? CustomColor.primary_60 : CustomColor.gray_60,
        size: 28,
      ),
    );
  }

  Widget _buildName() {
    return Text(
      member.name,
      style: CustomText.Body_Heavy_S_13.copyWith(
        color: isSelected ? CustomColor.primary_60 : CustomColor.gray_30,
      ),
      textAlign: TextAlign.center,
    );
  }
}

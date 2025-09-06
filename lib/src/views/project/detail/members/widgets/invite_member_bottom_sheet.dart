import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/theme/custom_text.dart';

class InviteMemberBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들 바
          _buildHandleBar(),
          // 제목
          _buildTitle(),
          // 초대장 섹션
          _buildInvitationCard(),
          // 구분선
          _buildDivider(),
          // 멤버 그리드
          Expanded(child: _buildMemberGrid()),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: CustomColor.gray_80,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24),
      child: Text(
        '함께 할 멤버를 초대해보세요',
        style: CustomText.Title_M_20.copyWith(color: CustomColor.gray_10),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInvitationCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColor.gray_80),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '콧구멍 개발자의 초대장',
                  style: CustomText.Label_Heavy_M_16.copyWith(
                    color: CustomColor.gray_10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '병원관련 서비스 프로젝트를 진행하려합니다.',
                  style: CustomText.Body_Light_M_14.copyWith(
                    color: CustomColor.gray_20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CustomColor.primary_60,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.link, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: CustomColor.gray_80,
    );
  }

  Widget _buildMemberGrid() {
    // 임시 데이터 - 실제로는 연락처나 추천 멤버 목록을 가져와야 함
    final suggestedMembers = [
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '카카오톡',
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '김혜빈',
      '김혜빈',
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemCount: suggestedMembers.length,
      itemBuilder: (context, index) {
        return _buildMemberItem(suggestedMembers[index]);
      },
    );
  }

  Widget _buildMemberItem(String name) {
    return GestureDetector(
      onTap: () {
        // 멤버 선택 로직
        print('Selected member: $name');
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: CustomColor.gray_90,
            child: Icon(Icons.person, color: CustomColor.gray_60, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: CustomText.Body_Light_XS_12.copyWith(
              color: CustomColor.gray_30,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

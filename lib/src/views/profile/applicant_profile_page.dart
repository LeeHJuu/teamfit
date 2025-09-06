import 'package:flutter/material.dart';
import '../../models/user_data.dart';
import '../../config/theme/custom_color.dart';
import '../../config/theme/custom_text.dart';
import '../../widgets/rounded_container.dart';
import '../../widgets/common_app_bar.dart';
import 'widgets/profile_header.dart';
import 'widgets/statistics_card.dart';
import 'widgets/profile_info_card.dart';
import 'widgets/position_experience_card.dart';
import 'widgets/skills_card.dart';

class ApplicantProfilePage extends StatelessWidget {
  final UserData member;

  const ApplicantProfilePage({Key? key, required this.member})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary_60,
      appBar: CommonAppBar(
        title: '설정',
        onBackPressed: () => Navigator.pop(context),
        onClosePressed: () => Navigator.pop(context),
      ),
      body: RoundedContainer(
        background: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 프로필 헤더
              ProfileHeader(member: member),
              const SizedBox(height: 16),
              // 통계 카드
              StatisticsCard(member: member),
              const SizedBox(height: 16),
              // 프로필 정보 카드
              Padding(
                padding: const EdgeInsets.all(20),
                child: ProfileInfoCard(member: member),
              ),
              // 포지션/경력 카드
              Padding(
                padding: const EdgeInsets.all(20),
                child: PositionExperienceCard(member: member),
              ),
              // 기술 카드
              Padding(
                padding: const EdgeInsets.all(20),
                child: SkillsCard(member: member),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildActionButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 거절하기 버튼
          Expanded(
            child: OutlinedButton(
              onPressed: () => _rejectApplicant(context),
              style: OutlinedButton.styleFrom(
                // side: BorderSide(color: CustomColor.gray_80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                '거절하기',
                style: CustomText.Body_Heavy_M_14.copyWith(
                  color: CustomColor.primary_60,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 수락하기 버튼
          Expanded(
            child: FilledButton(
              onPressed: () => _acceptApplicant(context),
              style: FilledButton.styleFrom(
                backgroundColor: CustomColor.primary_60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                '수락하기',
                style: CustomText.Body_Heavy_M_14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _rejectApplicant(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('지원자 거절'),
            content: Text('${member.nickname}님의 지원을 거절하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // 프로필 페이지 닫기
                  // 거절 로직 실행
                },
                child: Text('거절'),
              ),
            ],
          ),
    );
  }

  void _acceptApplicant(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('지원자 수락'),
            content: Text('${member.nickname}님의 지원을 수락하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // 프로필 페이지 닫기
                  // 수락 로직 실행
                },
                child: Text('수락'),
              ),
            ],
          ),
    );
  }
}

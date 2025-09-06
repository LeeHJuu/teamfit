import 'package:flutter/material.dart';
import '../../models/user_data.dart';
import '../../config/theme/custom_color.dart';
import '../../widgets/rounded_container.dart';
import '../../widgets/common_app_bar.dart';
import 'widgets/profile_header.dart';
import 'widgets/statistics_card.dart';
import 'widgets/profile_info_card.dart';
import 'widgets/position_experience_card.dart';
import 'widgets/skills_card.dart';

class MemberProfilePage extends StatelessWidget {
  final UserData member;

  const MemberProfilePage({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary_60,
      appBar: CommonAppBar(
        title: '팀원',
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
            ],
          ),
        ),
      ),
    );
  }
}

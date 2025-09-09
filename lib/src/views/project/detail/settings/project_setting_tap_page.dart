import 'package:flutter/material.dart';
import '../../../../models/user_data.dart';
import '../../../../config/enums.dart';
import '../../../../config/theme/custom_color.dart';
import '../../../../widgets/common_app_bar.dart';
import '../../../../widgets/rounded_container.dart';
import 'widgets/recruitment_post_card.dart';
import 'widgets/applicants_section.dart';
import '../../../profile/applicant_profile_page.dart';

class ProjectSettingTapPage extends StatefulWidget {
  @override
  _ProjectSettingTapPageState createState() => _ProjectSettingTapPageState();
}

class _ProjectSettingTapPageState extends State<ProjectSettingTapPage> {
  List<UserData> _applicants = [];

  @override
  void initState() {
    super.initState();
    _loadApplicants();
  }

  void _loadApplicants() {
    // 임시 데이터 - 실제로는 Firebase에서 가져와야 함
    _applicants = [
      UserData(
        uid: '1',
        email: 'leader@example.com',
        nickname: '불꽃리더',
        projectIds: ['project1'],
        role: UserRole.development,
        mannerTemperature: 85.0,
        attendanceRate: 100.0,
        mvpCount: 2,
        participationRate: 100.0,
      ),
      UserData(
        uid: '2',
        email: 'designer@example.com',
        nickname: '멋쟁이디쟈너',
        projectIds: ['project1'],
        role: UserRole.design,
        mannerTemperature: 75.0,
        attendanceRate: 95.0,
        mvpCount: 1,
        participationRate: 90.0,
      ),
      UserData(
        uid: '3',
        email: 'developer@example.com',
        nickname: '현쥬님짱',
        projectIds: ['project1'],
        role: UserRole.development,
        mannerTemperature: 90.0,
        attendanceRate: 100.0,
        mvpCount: 3,
        participationRate: 95.0,
      ),
    ];
  }

  void _navigateToProfile(UserData applicant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantProfilePage(member: applicant),
      ),
    );
  }

  void _endRecruitment() {
    // 모집 종료 로직
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('모집 종료'),
            content: Text('정말로 모집을 종료하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // 모집 종료 로직 실행
                },
                child: Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary_60,
      appBar: CommonAppBar(
        title: '설정',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: RoundedContainer(
        background: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 팀원 모집글 섹션
              RecruitmentPostCard(onEndRecruitment: _endRecruitment),
              const SizedBox(height: 32),
              // 지원자 섹션
              ApplicantsSection(
                applicants: _applicants,
                onProfileTap: _navigateToProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

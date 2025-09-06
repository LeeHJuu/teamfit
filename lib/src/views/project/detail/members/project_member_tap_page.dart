import 'package:flutter/material.dart';
import '../../../../models/user_data.dart';
import '../../../../models/user_detail_data.dart';
import '../../../../config/enums.dart';
import '../../../../config/theme/custom_color.dart';
import '../../../../config/theme/custom_text.dart';
import '../../../../widgets/rounded_container.dart';
import '../../../../widgets/common_app_bar.dart';
import 'widgets/team_member_list.dart';
import '../../../../widgets/bottom_sheets/invite_member_bottom_sheet.dart';
import '../../../profile/member_profile_page.dart';

class ProjectMemberTapPage extends StatefulWidget {
  @override
  _ProjectMemberTapPageState createState() => _ProjectMemberTapPageState();
}

class _ProjectMemberTapPageState extends State<ProjectMemberTapPage> {
  final TextEditingController _searchController = TextEditingController();
  List<UserData> _members = [];
  List<UserData> _filteredMembers = [];

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  void _loadMembers() {
    // 임시 데이터 - 실제로는 Firebase에서 가져와야 함
    _members = [
      UserData(
        uid: '1',
        email: 'leader@example.com',
        nickname: '불꽃리더',
        projectIds: ['project1'],
        detailData: UserDetailData(
          role: UserRole.development,
          mannerTemperature: 85.0,
          attendanceRate: 100.0,
          mvpCount: 2,
          participationRate: 100.0,
        ),
      ),
      UserData(
        uid: '2',
        email: 'designer@example.com',
        nickname: '멋쟁이디쟈너',
        projectIds: ['project1'],
        detailData: UserDetailData(
          role: UserRole.design,
          mannerTemperature: 75.0,
          attendanceRate: 95.0,
          mvpCount: 1,
          participationRate: 90.0,
        ),
      ),
      UserData(
        uid: '3',
        email: 'developer@example.com',
        nickname: '현쥬님짱',
        projectIds: ['project1'],
        detailData: UserDetailData(
          role: UserRole.development,
          mannerTemperature: 90.0,
          attendanceRate: 100.0,
          mvpCount: 3,
          participationRate: 95.0,
        ),
      ),
    ];
    _filteredMembers = List.from(_members);
  }

  void _filterMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMembers = List.from(_members);
      } else {
        _filteredMembers =
            _members
                .where(
                  (member) => member.nickname.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  void _showInviteBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InviteMemberBottomSheet(),
    );
  }

  void _navigateToProfile(UserData member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberProfilePage(member: member),
      ),
    );
  }

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
        child: Column(
          children: [
            // 검색 바
            _buildSearchBar(),
            // 팀원 목록
            Expanded(
              child: TeamMemberList(
                members: _filteredMembers,
                onMemberTap: _navigateToProfile,
                onInviteTap: _showInviteBottomSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.gray_80),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterMembers,
        decoration: InputDecoration(
          hintText: '검색',
          hintStyle: CustomText.Body_Light_M_14.copyWith(
            color: CustomColor.gray_60,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/team_member_selector.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/mvp_comment_field.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/mvp_submit_dialog.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';

class MvpVotePage extends StatefulWidget {
  final String projectId;

  const MvpVotePage({Key? key, required this.projectId}) : super(key: key);

  @override
  _MvpVotePageState createState() => _MvpVotePageState();
}

class _MvpVotePageState extends State<MvpVotePage> {
  String? selectedMemberId;
  String comment = '';

  final List<TeamMember> teamMembers = [
    TeamMember(id: '1', name: '협장', role: '협장'),
    TeamMember(id: '2', name: '밥식', role: '밥식'),
    TeamMember(id: '3', name: '부남', role: '부남'),
    TeamMember(id: '4', name: '낭남', role: '낭남'),
    TeamMember(id: '5', name: '농농', role: '농농'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 32),
                  _buildMvpSelector(),
                  SizedBox(height: 32),
                  _buildCommentSection(),
                ],
              ),
            ),
          ),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: CustomColor.gray_10),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이번 프로젝트에서\n최고의 팀원은 누구인가요?', style: CustomText.Headline_S_24),
        SizedBox(height: 12),
        Text(
          '투표는 익명으로 진행되니 걱정마세요!',
          style: CustomText.Body_Light_M_14.copyWith(
            color: CustomColor.gray_50,
          ),
        ),
      ],
    );
  }

  Widget _buildMvpSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MVP 한 명을 선택해주세요', style: CustomText.Label_Heavy_M_16),
        SizedBox(height: 16),
        TeamMemberSelector(
          members: teamMembers,
          selectedMemberId: selectedMemberId,
          onMemberSelected: (memberId) {
            setState(() {
              selectedMemberId = memberId;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('코멘트를 남겨주세요 (선택)', style: CustomText.Label_Heavy_M_16),
        SizedBox(height: 16),
        MvpCommentField(
          onCommentChanged: (value) {
            setState(() {
              comment = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return NextStepBottomButton(
      title: '제출하기',
      isPossible: selectedMemberId != null,
      moveNext: () => _showSubmitDialog(),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder:
          (context) => MvpSubmitDialog(
            onConfirm: () {
              Navigator.pop(context); // 다이얼로그 닫기
              _submitVote();
            },
            onCancel: () => Navigator.pop(context),
          ),
    );
  }

  void _submitVote() {
    // TODO: MVP 투표 제출 로직 구현
    print('MVP 투표 제출: $selectedMemberId, 코멘트: $comment');
    Navigator.pop(context); // 페이지 닫기
  }
}

class TeamMember {
  final String id;
  final String name;
  final String role;

  TeamMember({required this.id, required this.name, required this.role});
}

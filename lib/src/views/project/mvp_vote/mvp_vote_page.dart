import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/mvp_vote_view_model.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/team_member_selector.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/mvp_comment_field.dart';
import 'package:teamfit/src/views/project/mvp_vote/widgets/mvp_submit_dialog.dart';
import 'package:teamfit/src/widgets/components/next_step_bottom_button.dart';

class MvpVotePage extends ConsumerStatefulWidget {
  final String projectId;

  const MvpVotePage({Key? key, required this.projectId}) : super(key: key);

  @override
  ConsumerState<MvpVotePage> createState() => _MvpVotePageState();
}

class _MvpVotePageState extends ConsumerState<MvpVotePage> {
  @override
  void initState() {
    super.initState();
    // 위젯이 생성될 때 팀원 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mvpVoteViewModel.notifier).loadTeamMembers(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mvpVoteViewModel);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  SizedBox(height: 32),
                  mvpSelector(state),
                  SizedBox(height: 32),
                  commentSection(state),
                ],
              ),
            ),
          ),
          submitButton(state),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: CustomColor.gray_10),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget header() {
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

  Widget mvpSelector(MvpVoteState state) {
    if (state.isLoading) {
      return Container(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('팀원 정보를 불러올 수 없습니다'),
              SizedBox(height: 8),
              FilledButton(
                onPressed:
                    () => ref
                        .read(mvpVoteViewModel.notifier)
                        .loadTeamMembers(widget.projectId),
                child: Text('다시 시도', style: TextStyle()),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MVP 한 명을 선택해주세요', style: CustomText.Label_Heavy_M_16),
        SizedBox(height: 16),
        TeamMemberSelector(
          members: state.teamMembers,
          selectedMemberId: state.selectedMemberId,
          onMemberSelected: (memberId) {
            ref.read(mvpVoteViewModel.notifier).setSelectedMember(memberId);
          },
        ),
      ],
    );
  }

  Widget commentSection(MvpVoteState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('코멘트를 남겨주세요 (선택)', style: CustomText.Label_Heavy_M_16),
        SizedBox(height: 16),
        MvpCommentField(
          onCommentChanged: (comment) {
            ref.read(mvpVoteViewModel.notifier).setComment(comment);
          },
        ),
      ],
    );
  }

  Widget submitButton(MvpVoteState state) {
    return NextStepBottomButton(
      title: state.isSubmitting ? '제출 중...' : '제출하기',
      isPossible: state.canSubmit,
      moveNext: () => _showSubmitDialog(),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder:
          (context) => MvpSubmitDialog(
            onConfirm: () async {
              Navigator.pop(context); // 다이얼로그 닫기
              final success =
                  await ref.read(mvpVoteViewModel.notifier).submitVote();
              if (success) {
                Navigator.pop(context); // 페이지 닫기
              } else {
                // 에러 처리
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('투표 제출에 실패했습니다. 다시 시도해주세요.')),
                );
              }
            },
            onCancel: () => Navigator.pop(context),
          ),
    );
  }
}

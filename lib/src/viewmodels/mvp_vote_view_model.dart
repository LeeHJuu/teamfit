import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/models/team_member.dart';

/// MVP 투표 상태 클래스
class MvpVoteState {
  final String? selectedMemberId;
  final String comment;
  final bool isSubmitting;
  final List<TeamMember> teamMembers;
  final bool isLoading;
  final String? error;

  MvpVoteState({
    this.selectedMemberId,
    this.comment = '',
    this.isSubmitting = false,
    this.teamMembers = const [],
    this.isLoading = false,
    this.error,
  });

  MvpVoteState copyWith({
    String? selectedMemberId,
    String? comment,
    bool? isSubmitting,
    List<TeamMember>? teamMembers,
    bool? isLoading,
    String? error,
  }) {
    return MvpVoteState(
      selectedMemberId: selectedMemberId ?? this.selectedMemberId,
      comment: comment ?? this.comment,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      teamMembers: teamMembers ?? this.teamMembers,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get canSubmit => selectedMemberId != null && !isSubmitting;
}

/// MVP 투표 ViewModel
class MvpVoteViewModel extends StateNotifier<MvpVoteState> {
  MvpVoteViewModel() : super(MvpVoteState());

  /// 선택된 멤버 설정
  void setSelectedMember(String? memberId) {
    state = state.copyWith(selectedMemberId: memberId);
  }

  /// 코멘트 설정
  void setComment(String comment) {
    state = state.copyWith(comment: comment);
  }

  /// 팀원 목록 로드
  Future<void> loadTeamMembers(String projectId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: 실제로는 API에서 팀원 정보를 가져옴
      await Future.delayed(Duration(milliseconds: 300));
      final members = [
        TeamMember(id: '1', name: '협장', role: '협장'),
        TeamMember(id: '2', name: '밥식', role: '밥식'),
        TeamMember(id: '3', name: '부남', role: '부남'),
        TeamMember(id: '4', name: '낭남', role: '낭남'),
        TeamMember(id: '5', name: '농농', role: '농농'),
      ];
      state = state.copyWith(teamMembers: members, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '팀원 정보 로딩 실패: $e');
    }
  }

  /// MVP 투표 제출
  Future<bool> submitVote() async {
    if (!state.canSubmit) return false;

    state = state.copyWith(isSubmitting: true, error: null);

    try {
      // TODO: MVP 투표 제출 API 호출
      await Future.delayed(Duration(seconds: 1)); // 시뮬레이션
      print('MVP 투표 제출: ${state.selectedMemberId}, 코멘트: ${state.comment}');

      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: 'MVP 투표 제출 실패: $e');
      return false;
    }
  }

  /// 상태 초기화
  void reset() {
    state = MvpVoteState();
  }
}

/// MVP 투표 ViewModel Provider
final mvpVoteViewModel = StateNotifierProvider<MvpVoteViewModel, MvpVoteState>(
  (ref) => MvpVoteViewModel(),
);

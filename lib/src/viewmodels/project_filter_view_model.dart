import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/models/filter_item.dart';

/// 프로젝트 필터 상태 클래스
class ProjectFilterState {
  final UserGoal? selectedProjectType;
  final UserRole? selectedPosition;
  final ProjectMemberCareerLevel? selectedExperience;
  final MeetingType? selectedMeeting;

  ProjectFilterState({
    this.selectedProjectType,
    this.selectedPosition,
    this.selectedExperience,
    this.selectedMeeting,
  });

  ProjectFilterState copyWith({
    UserGoal? selectedProjectType,
    UserRole? selectedPosition,
    ProjectMemberCareerLevel? selectedExperience,
    MeetingType? selectedMeeting,
  }) {
    return ProjectFilterState(
      selectedProjectType: selectedProjectType ?? this.selectedProjectType,
      selectedPosition: selectedPosition ?? this.selectedPosition,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      selectedMeeting: selectedMeeting ?? this.selectedMeeting,
    );
  }

  bool get hasActiveFilters =>
      selectedProjectType != null ||
      selectedPosition != null ||
      selectedExperience != null ||
      selectedMeeting != null;
}

/// 프로젝트 필터 ViewModel
class ProjectFilterViewModel extends StateNotifier<ProjectFilterState> {
  ProjectFilterViewModel() : super(ProjectFilterState());

  /// 프로젝트 유형 설정
  void setProjectType(UserGoal? value) {
    state = state.copyWith(selectedProjectType: value);
    _applyFilters();
  }

  /// 포지션 설정
  void setPosition(UserRole? value) {
    state = state.copyWith(selectedPosition: value);
    _applyFilters();
  }

  /// 경력 설정
  void setExperience(ProjectMemberCareerLevel? value) {
    state = state.copyWith(selectedExperience: value);
    _applyFilters();
  }

  /// 진행 방식 설정
  void setMeeting(MeetingType? value) {
    state = state.copyWith(selectedMeeting: value);
    _applyFilters();
  }

  /// 모든 필터 초기화
  void clearAllFilters() {
    state = ProjectFilterState();
    _applyFilters();
  }

  void _applyFilters() {
    // TODO: 필터 적용 로직 구현 (프로젝트 목록 필터링)
    print(
      '필터 적용: 유형=${state.selectedProjectType}, 포지션=${state.selectedPosition}, 경력=${state.selectedExperience}, 방식=${state.selectedMeeting}',
    );
  }

  // 필터 옵션들을 제공하는 getter들
  List<FilterItem<UserGoal>> get projectTypeItems => [
    FilterItem('프로젝트 유형', null),
    ...UserGoal.values.map((e) => FilterItem(e.label, e)),
  ];

  List<FilterItem<UserRole>> get positionItems => [
    FilterItem('포지션', null),
    FilterItem('개발', UserRole.development),
    FilterItem('디자인', UserRole.design),
    FilterItem('경영·비즈니스', UserRole.business),
    FilterItem('마케팅·광고', UserRole.marketing),
  ];

  List<FilterItem<ProjectMemberCareerLevel>> get experienceItems => [
    FilterItem('경력', null),
    ...ProjectMemberCareerLevel.values.map((e) => FilterItem(e.label, e)),
  ];

  List<FilterItem<MeetingType>> get meetingItems => [
    FilterItem('진행 방식', null),
    ...MeetingType.values.map((e) => FilterItem(e.label, e)),
  ];
}

/// 프로젝트 필터 ViewModel Provider
final projectFilterViewModel =
    StateNotifierProvider<ProjectFilterViewModel, ProjectFilterState>(
      (ref) => ProjectFilterViewModel(),
    );

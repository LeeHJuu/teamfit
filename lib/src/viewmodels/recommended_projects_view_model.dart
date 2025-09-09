import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';

/// 추천 프로젝트 상태 클래스
class RecommendedProjectsState {
  final List<ProjectRecruitInfo> projects;
  final int currentIndex;
  final bool isLoading;
  final String? error;
  final String userName;

  RecommendedProjectsState({
    this.projects = const [],
    this.currentIndex = 0,
    this.isLoading = false,
    this.error,
    this.userName = '냥냥',
  });

  RecommendedProjectsState copyWith({
    List<ProjectRecruitInfo>? projects,
    int? currentIndex,
    bool? isLoading,
    String? error,
    String? userName,
  }) {
    return RecommendedProjectsState(
      projects: projects ?? this.projects,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userName: userName ?? this.userName,
    );
  }
}

/// 추천 프로젝트 ViewModel
class RecommendedProjectsViewModel
    extends StateNotifier<RecommendedProjectsState> {
  RecommendedProjectsViewModel() : super(RecommendedProjectsState());

  /// 현재 인덱스 설정
  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  /// 추천 프로젝트 로드
  Future<void> loadRecommendedProjects() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: 실제 API 호출로 대체
      await Future.delayed(Duration(milliseconds: 500));
      final projects = _generateSampleData();
      state = state.copyWith(projects: projects, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '추천 프로젝트 로딩 실패: $e');
    }
  }

  List<ProjectRecruitInfo> _generateSampleData() {
    final sampleData = [
      {
        'title': '병원관련 프로젝트 진행하려합니다!',
        'introduction': '의료진과 환자를 연결하는 플랫폼 개발',
        'teamName': '메디컬팀',
      },
      {
        'title': '공모전 프로젝트 이름/최대 20자/최대 2줄',
        'introduction': '혁신적인 아이디어로 공모전 우승을 목표로 하는 프로젝트',
        'teamName': '혁신팀',
      },
      {
        'title': '해커톤 프로젝트 이름/최대 20자/최대 2줄',
        'introduction': '48시간 해커톤에서 MVP 개발',
        'teamName': '스프린트팀',
      },
    ];

    return sampleData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return ProjectRecruitInfo(
        id: 'recommended_$index',
        projectId: 'project_$index',
        title: data['title'] as String,
        introduction: data['introduction'] as String,
        teamName: data['teamName'] as String,
        recruitMembers: [],
        authorId: 'author_$index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }).toList();
  }
}

/// 추천 프로젝트 ViewModel Provider
final recommendedProjectsViewModel = StateNotifierProvider<
  RecommendedProjectsViewModel,
  RecommendedProjectsState
>((ref) => RecommendedProjectsViewModel());

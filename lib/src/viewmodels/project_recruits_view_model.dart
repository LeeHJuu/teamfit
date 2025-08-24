import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_recruit_info.dart';
import '../provider.dart';

class ProjectRecruitsViewModel
    extends AutoDisposeNotifier<List<ProjectRecruitInfo>> {
  @override
  List<ProjectRecruitInfo> build() {
    // 초기화 시 모집글 목록 로드
    loadRecruitInfos();
    return [];
  }

  // 모집글 목록 로드
  Future<void> loadRecruitInfos({
    String? keyword,
    List<String>? techStack,
    String? duration,
    String? meetingType,
    int limit = 20,
  }) async {
    final recruitInfos =
        await ref.read(projectServiceProvider).getRecruitInfoList();
    state = recruitInfos;
  }

  // 새로고침
  Future<void> refresh() async {
    await loadRecruitInfos();
  }

  // 검색 필터 적용
  Future<void> searchWithFilters({
    String? keyword,
    String? duration,
    String? meetingType,
  }) async {
    await loadRecruitInfos(
      keyword: keyword,
      duration: duration,
      meetingType: meetingType,
    );
  }
}

final projectRecruitsViewModel = NotifierProvider.autoDispose<
  ProjectRecruitsViewModel,
  List<ProjectRecruitInfo>
>(() => ProjectRecruitsViewModel());

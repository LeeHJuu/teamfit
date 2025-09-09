import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/viewmodels/project_recruits_view_model.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/project_list_item.dart';

class AllTeamProjects extends ConsumerWidget {
  const AllTeamProjects({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectRecruitsViewModel);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('전체 팀프로젝트', style: CustomText.Title_S_18),
        ),
        SizedBox(height: 16),
        // 실제 데이터가 있으면 사용하고, 없으면 샘플 데이터 표시
        ...state.isNotEmpty
            ? state.map((e) => ProjectListItem(e))
            : _getSampleProjects().map((e) => ProjectListItem(e)),
      ],
    );
  }

  List<ProjectRecruitInfo> _getSampleProjects() {
    return [
      ProjectRecruitInfo(
        id: 'sample_1',
        projectId: 'project_1',
        title: '프로젝트 이름/최대 20자/최대 2줄',
        introduction: '공모전 프로젝트 설명입니다.',
        teamName: '팀 이름',
        recruitMembers: [],
        authorId: 'author_1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      ProjectRecruitInfo(
        id: 'sample_2',
        projectId: 'project_2',
        title: '프로젝트 이름/최대 20자/최대 2줄',
        introduction: '해커톤 프로젝트 설명입니다.',
        teamName: '팀 이름',
        recruitMembers: [],
        authorId: 'author_2',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}

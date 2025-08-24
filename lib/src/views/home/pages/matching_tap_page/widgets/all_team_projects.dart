import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/project_recruits_view_model.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/project_item_box.dart';

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
        ...state.map((e) => ProjectItemBox(e)),
      ],
    );
  }
}

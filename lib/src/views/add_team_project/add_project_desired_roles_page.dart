import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/models/recruit_member.dart';
import 'package:teamfit/src/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';
import 'package:teamfit/src/views/add_team_project/widgets/desired_roles_bottom_sheet.dart';
import 'package:teamfit/src/views/add_team_project/widgets/desired_role_box.dart';
import 'package:teamfit/src/views/add_team_project/add_project_preferred_members_page.dart';

class AddProjectDesiredRolesPage extends ConsumerStatefulWidget {
  const AddProjectDesiredRolesPage({super.key});

  @override
  ConsumerState<AddProjectDesiredRolesPage> createState() =>
      _AddProjectDesiredRolesPageState();
}

class _AddProjectDesiredRolesPageState
    extends ConsumerState<AddProjectDesiredRolesPage> {
  final bool _isPossible = true;
  List<RecruitMember> recruitMembers = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTeamProjectViewModel);

    return PopScope(
      onPopInvoked: (didPop) {
        ref.read(addTeamProjectViewModel.notifier).goBack();
        return;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CustomProgressBar(
              progress: (state.index).toDouble() / state.count.toDouble(),
            ),
            Expanded(
              child: ListView(
                children: [
                  TestStepTitle('04', '모집 인원과 바라는 팀원'),
                  ...recruitMembers.map(
                    (member) => DesiredRoleBox(
                      role: member.role,
                      count: member.count,
                      technologies: member.technologies,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return DesiredRolesBottomSheet(
                            onComplete: (member) {
                              setState(() {
                                recruitMembers.add(member);
                              });
                            },
                          );
                        },
                      );
                    },
                    child: ShadowBoxContainer(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.add), Text('추가하기')],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _nextStepButton(context),
          ],
        ),
      ),
    );
  }

  NextStepBottomButton _nextStepButton(BuildContext context) {
    return NextStepBottomButton(
      title: '다음',
      isPossible: _isPossible,
      moveNext: () {
        // 모집 팀원 정보를 ViewModel에 저장
        ref
            .read(addTeamProjectViewModel.notifier)
            .setRecruitMembers(recruitMembers);

        ref.read(addTeamProjectViewModel.notifier).nextStep(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddProjectPreferredMembersPage(),
          ),
        );
      },
    );
  }
}

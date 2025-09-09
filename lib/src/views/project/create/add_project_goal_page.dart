import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/views/personality/widgets/test_step_title.dart';
import 'package:teamfit/src/views/project/create/add_project_info_page.dart';
import 'package:teamfit/src/widgets/components/custom_progress_bar.dart';
import 'package:teamfit/src/widgets/components/custom_select_button.dart';
import 'package:teamfit/src/widgets/components/next_step_bottom_button.dart';

class AddProjectGoalPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectGoalPage> createState() => _AddProjectGoalPageState();
}

class _AddProjectGoalPageState extends ConsumerState<AddProjectGoalPage> {
  bool _isPossible = false;

  List<UserGoal> projectGoals = UserGoal.values;
  UserGoal? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTeamProjectViewModel);

    return Scaffold(
      appBar: AppBar(
      scrolledUnderElevation: 0,),
      body: Column(
        children: [
          CustomProgressBar(
            progress: (state.index).toDouble() / state.count.toDouble(),
          ),
          TestStepTitle('01', '어떤 프로젝트를 시작하고 싶나요?'),
          _projectGoalTagsBox(),
          NextStepBottomButton(
            title: 'button_text.next'.tr(),
            isPossible: _isPossible,
            moveNext: () {
              ref.read(addTeamProjectViewModel.notifier).nextStep(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProjectInfoPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _projectGoalTagsBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 20, // 상하 간격
            crossAxisSpacing: 10, // 좌우 간격
            mainAxisExtent: 50,
          ),
          itemCount: projectGoals.length, // 총 아이템 갯수
          itemBuilder: (context, index) {
            final goal = projectGoals[index];
            return CustomSelectButton(
              title: goal.label,
              textAlign: 0,
              isSelected: selectedGoal == goal,
              onPress: () {
                setState(() {
                  selectedGoal = goal;
                  _isPossible = selectedGoal != null;
                });
                final vm = ref.read(addTeamProjectViewModel.notifier);
                vm.setProjectGoal(goal);
              },
            );
          },
        ),
      ),
    );
  }
}

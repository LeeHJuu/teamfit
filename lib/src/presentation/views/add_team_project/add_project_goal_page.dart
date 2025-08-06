import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_info_page.dart';

class AddProjectGoalPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectGoalPage> createState() => _AddProjectGoalPageState();
}

class _AddProjectGoalPageState extends ConsumerState<AddProjectGoalPage> {
  bool _isPossible = false;

  List<String> projectGoals = 'signin_page.user_goal.items'.tr().split(',');
  String selectedGoal = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTeamProjectViewModel);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomProgressBar(progress: state.progress),
          TestStepTitle('01', '어떤 프로젝트를 시작하고 싶나요?'),
          SizedBox(height: 50),
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
            return CustomSelectButton(
              title: projectGoals[index],
              textAlign: 0,
              isSelected: selectedGoal == projectGoals[index],
              onPress: () {
                setState(() {
                  selectedGoal = projectGoals[index];
                  _isPossible = selectedGoal.isNotEmpty;
                });
                final vm = ref.read(loginViewModel.notifier);
                vm.setUserGoal(selectedGoal);
              },
            );
          },
        ),
      ),
    );
  }
}

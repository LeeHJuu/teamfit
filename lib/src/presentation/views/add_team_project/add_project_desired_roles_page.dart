import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/finish_add_project_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectDesiredRolesPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectDesiredRolesPage> createState() =>
      _AddProjectDesiredRolesPageState();
}

class _AddProjectDesiredRolesPageState
    extends ConsumerState<AddProjectDesiredRolesPage> {
  bool _isPossible = true;

  // 열정온도와 경력 관련 태그들을 enum에서 가져옴
  final List<PassionLevel> passionTags = PassionLevel.values;

  final List<CareerLevel> experienceTags = CareerLevel.values;

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
            CustomProgressBar(progress: state.progress),
            Expanded(
              child: ListView(
                children: [
                  TestStepTitle('04', '모집 인원과 바라는 팀원'),
                  // _recruitMemberColumn(),
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
        ref.read(addTeamProjectViewModel.notifier).nextStep(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishAddProjectPage()),
        );
      },
    );
  }
}

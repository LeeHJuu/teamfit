import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/finish_add_project_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectDesiredRolesPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectDesiredRolesPage> createState() =>
      _AddProjectDesiredRolesPageState();
}

class _AddProjectDesiredRolesPageState
    extends ConsumerState<AddProjectDesiredRolesPage> {
  bool _isPossible = true;
  final tags = ['온도 50도 이상인 분 원해요', '온도 상관없어요', '경력자 원해요', '신입 환영해요'];

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
                  SizedBox(height: 50),
                  _recruitMemberColumn(),
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

  Column _recruitMemberColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBoxItem(
          title: '이런 분을 찾아요',
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Icon(Icons.add), Text('추가하기')],
              ),
            ],
          ),
        ),
        InputBoxItem(title: '이런 분을 원해요', body: _wantedMemberType()),
      ],
    );
  }

  Wrap _wantedMemberType() {
    return Wrap(
      children:
          tags.map((e) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(right: 5, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              child: Text(e),
            );
          }).toList(),
    );
  }
}

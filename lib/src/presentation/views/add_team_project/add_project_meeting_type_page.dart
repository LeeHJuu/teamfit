import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_desired_roles_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/custom_dropdown_menu.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectMeetingTypePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectMeetingTypePage> createState() =>
      _AddProjectMeetingTypePageState();
}

class _AddProjectMeetingTypePageState
    extends ConsumerState<AddProjectMeetingTypePage> {
  bool _isPossible = true;

  int selectecMeetingType = 10;
  void _updateIsPossible() {
    // setState(() {
    //   _isPossible =
    //       _nameTextController.text.trim().isNotEmpty &&
    //       _birthYearController.text.trim().isNotEmpty &&
    //       _birthMonthController.text.trim().isNotEmpty &&
    //       _birthDayController.text.trim().isNotEmpty;
    // });
  }

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
            TestStepTitle('03', '협업 방식을 설정해주세요.'),
            SizedBox(height: 50),
            _meetingTypeInputBox(),
            Spacer(),
            _nextStepButton(context),
          ],
        ),
      ),
    );
  }

  Column _meetingTypeInputBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBoxItem(
          title: '프로젝트 기간',
          body: CustomDropdownMenu(
            title: '선택',
            items: ['1', '2', '3', '4'],
            onSelect: (p0) {},
            selectedItem: '',
          ),
        ),
        InputBoxItem(title: '회의 방식', body: _meetingTypeBox()),
      ],
    );
  }

  Row _meetingTypeBox() {
    return Row(
      children: [
        _meetingTypeButton(0),
        SizedBox(width: 10),
        _meetingTypeButton(1),
      ],
    );
  }

  Expanded _meetingTypeButton(int meetingType) {
    return Expanded(
      child: CustomSelectButton(
        title: meetingType == 0 ? '오프라인' : '온라인',
        textAlign: 1,
        isSelected: selectecMeetingType == meetingType,
        onPress: () {
          setState(() {
            selectecMeetingType = meetingType;
          });
          _updateIsPossible();
        },
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
          MaterialPageRoute(builder: (context) => AddProjectDesiredRolesPage()),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_desired_roles_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/custom_dropdown_menu.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';
import 'package:teamfit/src/presentation/widgets/custom_text_field.dart';
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
  String? _selectedDuration; // 선택된 기간을 저장할 변수 추가

  int selectecMeetingType = 10;

  void _updateIsPossible() {
    setState(() {
      _isPossible = _selectedDuration != null && selectecMeetingType != 10;
    });
  }

  void _onDurationSelected(String? duration) {
    setState(() {
      _selectedDuration = duration;
    });
    _updateIsPossible();
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
        body: ListView(
          children: [
            CustomProgressBar(progress: state.progress),
            TestStepTitle('03', '협업 방식을 설정해주세요.'),
            // SizedBox(height: 50),
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
          title: '팀 이름',
          body: CustomTextField(
            hintText: '팀 이름을 입력해주세요',
            maxLength: 20,
            textController: TextEditingController(),
          ),
        ),
        InputBoxItem(
          title: '프로젝트 기간',
          body: CustomDropdownMenu(
            title: '프로젝트 기간을 선택해주세요.',
            items: ['1개월', '2개월', '3개월', '4개월'],
            onSelect: _onDurationSelected,
            selectedItem: _selectedDuration,
          ),
        ),
        InputBoxItem(
          title: '회의 방식',
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3.5,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _meetingTypeButton(0),
                _meetingTypeButton(1),
                _meetingTypeButton(2),
                _meetingTypeButton(3),
              ],
            ),
          ),
        ),
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
    String getMeetingTypeTitle(int type) {
      switch (type) {
        case 0:
          return '온라인';
        case 1:
          return '오프라인';
        case 2:
          return '온/오프라인';
        case 3:
          return '협의';
        default:
          return '';
      }
    }

    return Expanded(
      child: CustomSelectButton(
        title: getMeetingTypeTitle(meetingType),
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

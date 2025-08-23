import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/views/add_team_project/add_project_desired_roles_page.dart';
import 'package:teamfit/src/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/widgets/custom_dropdown_menu.dart';
import 'package:teamfit/src/widgets/custom_select_button.dart';
import 'package:teamfit/src/widgets/custom_text_field.dart';
import 'package:teamfit/src/widgets/input_box_item.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';

class AddProjectMeetingTypePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectMeetingTypePage> createState() =>
      _AddProjectMeetingTypePageState();
}

class _AddProjectMeetingTypePageState
    extends ConsumerState<AddProjectMeetingTypePage> {
  bool _isPossible = false;
  ProjectDuration? _selectedDuration;
  MeetingType? selectedMeetingType;
  final TextEditingController _teamNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _teamNameController.addListener(_updateIsPossible);
  }

  @override
  void dispose() {
    _teamNameController.removeListener(_updateIsPossible);
    _teamNameController.dispose();
    super.dispose();
  }

  void _updateIsPossible() {
    setState(() {
      _isPossible =
          _teamNameController.text.trim().isNotEmpty &&
          _selectedDuration != null &&
          selectedMeetingType != null;
    });
  }

  void _onDurationSelected(String? duration) {
    setState(() {
      _selectedDuration = ProjectDuration.values.firstWhere(
        (e) => e.label == duration,
        orElse: () => ProjectDuration.oneMonth,
      );
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
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomProgressBar(
                    progress: (state.index).toDouble() / state.count.toDouble(),
                  ),
                  TestStepTitle('03', '협업 방식을 설정해주세요.'),
                  // SizedBox(height: 50),
                  _meetingTypeInputBox(),
                ],
              ),
            ),
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
            textController: _teamNameController,
          ),
        ),
        InputBoxItem(
          title: '프로젝트 기간',
          body: CustomDropdownMenu(
            title: '프로젝트 기간을 선택해주세요.',
            items:
                ProjectDuration.values
                    .where(
                      (e) =>
                          e != ProjectDuration.oneToSixMonths &&
                          e != ProjectDuration.regular,
                    )
                    .map((e) => e.label)
                    .toList(),
            onSelect: _onDurationSelected,
            selectedItem: _selectedDuration?.label,
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
              children:
                  MeetingType.values
                      .map((type) => _meetingTypeButton(type))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _meetingTypeButton(MeetingType meetingType) {
    return CustomSelectButton(
      title: meetingType.label,
      textAlign: 1,
      isSelected: selectedMeetingType == meetingType,
      onPress: () {
        setState(() {
          selectedMeetingType = meetingType;
        });
        _updateIsPossible();
      },
    );
  }

  NextStepBottomButton _nextStepButton(BuildContext context) {
    return NextStepBottomButton(
      title: '다음',
      isPossible: _isPossible,
      moveNext: () {
        final vm = ref.read(addTeamProjectViewModel.notifier);
        vm.setTeamInfo(
          teamName: _teamNameController.text.trim(),
          duration: _selectedDuration!,
          meetingType: selectedMeetingType!,
        );
        vm.nextStep(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProjectDesiredRolesPage()),
        );
      },
    );
  }
}

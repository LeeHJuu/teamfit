import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/finish_add_project_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';
import 'package:teamfit/src/presentation/widgets/shadow_box_container.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';

class AddProjectPreferredMembersPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectPreferredMembersPage> createState() =>
      _AddProjectPreferredMembersPageState();
}

class _AddProjectPreferredMembersPageState
    extends ConsumerState<AddProjectPreferredMembersPage> {
  PassionLevel? _selectedPassionLevel;
  CareerLevel? _selectedCareerLevel;

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
                  TestStepTitle('05', '희망하는 팀원의 열정온도와 경력'),
                  const SizedBox(height: 20),

                  // 열정온도 선택
                  _buildSelectionSection(
                    title: '열정온도',
                    options: PassionLevel.values,
                    selectedValue: _selectedPassionLevel,
                    onChanged: (PassionLevel? value) {
                      setState(() {
                        _selectedPassionLevel = value;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // 경력 선택
                  _buildSelectionSection(
                    title: '경력',
                    options: CareerLevel.values,
                    selectedValue: _selectedCareerLevel,
                    onChanged: (CareerLevel? value) {
                      setState(() {
                        _selectedCareerLevel = value;
                      });
                    },
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

  Widget _buildSelectionSection<T>({
    required String title,
    required List<T> options,
    required T? selectedValue,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                options.map((option) {
                  final label = (option as dynamic).label;
                  final isSelected = option == selectedValue;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: IntrinsicWidth(
                      child: CustomSelectButton(
                        title: label,
                        textAlign: 0,
                        isSelected: isSelected,
                        onPress: () {
                          onChanged(isSelected ? null : option);
                        },
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  NextStepBottomButton _nextStepButton(BuildContext context) {
    return NextStepBottomButton(
      title: '다음',
      isPossible: _selectedPassionLevel != null && _selectedCareerLevel != null,
      moveNext: () {
        // 선택된 값들을 ViewModel에 저장
        ref
            .read(addTeamProjectViewModel.notifier)
            .setPreferredMemberInfo(
              passionLevel: _selectedPassionLevel!,
              careerLevel: _selectedCareerLevel!,
            );

        ref.read(addTeamProjectViewModel.notifier).nextStep(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishAddProjectPage()),
        );
      },
    );
  }
}

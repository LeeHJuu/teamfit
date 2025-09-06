import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/enums.dart';
import '../../config/theme/custom_color.dart';
import '../../config/theme/custom_text.dart';
import '../../models/recruit_member.dart';
import '../../viewmodels/add_team_project_view_model.dart';
import '../custom_select_button.dart';
import '../custom_text_field.dart';
import '../next_step_bottom_button.dart';

class DesiredRolesBottomSheet extends ConsumerStatefulWidget {
  final Function(RecruitMember) onComplete;

  const DesiredRolesBottomSheet({super.key, required this.onComplete});

  @override
  ConsumerState<DesiredRolesBottomSheet> createState() =>
      _DesiredRolesBottomSheetState();
}

class _DesiredRolesBottomSheetState
    extends ConsumerState<DesiredRolesBottomSheet> {
  int currentStep = 0;
  UserRole? selectedRole;
  List<String> technologies = [];
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _techController = TextEditingController();

  @override
  void dispose() {
    _countController.dispose();
    _techController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _complete() {
    if (selectedRole != null) {
      final member = RecruitMember(
        role: selectedRole!,
        count: int.parse(_countController.text.trim()),
        technologies: technologies,
      );

      // 뷰모델에 모집 팀원 정보 추가
      final currentMembers =
          ref.read(addTeamProjectViewModel).projectInfo?.recruitMembers ?? [];
      final updatedMembers = [...currentMembers, member];
      ref
          .read(addTeamProjectViewModel.notifier)
          .setRecruitMembers(updatedMembers);

      // 콜백 호출
      widget.onComplete(member);
      Navigator.pop(context);
    }
  }

  bool get _canProceed {
    switch (currentStep) {
      case 0:
        return selectedRole != null;
      case 1:
        return true;
      case 2:
        return int.tryParse(_countController.text.trim()) != null;
      default:
        return false;
    }
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0:
        return '직무';
      case 1:
        return '인원';
      case 2:
        return '기술';
      default:
        return '';
    }
  }

  String get _buttonText {
    return currentStep == 2 ? '완료' : '다음';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 단계 표시
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(
                onPressed: currentStep > 0 ? _previousStep : null,
                icon: Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Text(
                  _getStepTitle(),
                  style: CustomText.Label_Light_M_16,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48), // 뒤로가기 버튼과 대칭
            ],
          ),
        ),

        // 단계별 내용
        Padding(padding: const EdgeInsets.all(20), child: _buildStepContent()),

        // 하단 버튼
        NextStepBottomButton(
          title: _buttonText,
          isPossible: _canProceed,
          moveNext: currentStep == 2 ? _complete : _nextStep,
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildRoleSelection();
      case 1:
        return _buildCountSelection();
      case 2:
        return _buildTechnologySelection();
      default:
        return Container();
    }
  }

  Widget _buildRoleSelection() {
    return SizedBox(
      height: 400, // GridView에 명시적 높이 제약
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20, // 상하 간격
          crossAxisSpacing: 10, // 좌우 간격
          mainAxisExtent: 50,
        ),
        itemCount: UserRole.values.length,
        itemBuilder: (context, index) {
          final role = UserRole.values[index];
          return CustomSelectButton(
            title: role.label,
            textAlign: 1,
            isSelected: selectedRole == role,
            onPress: () {
              setState(() {
                selectedRole = role;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildCountSelection() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: '필요 인원을 입력해주세요 (예: 1)',
            onSubmit: () {
              // 입력 완료 처리
            },
            textController: _countController,
          ),
        ),
        SizedBox(width: 10),
        Text('명', style: CustomText.Label_Light_M_16),
      ],
    );
  }

  Widget _buildTechnologySelection() {
    return Column(
      children: [
        CustomTextField(
          textController: _techController,
          hintText: '기술을 입력하고 Enter를 누르세요',
          onSubmit: () {
            if (_techController.text.trim().isNotEmpty) {
              setState(() {
                technologies.add(_techController.text.trim());
                _techController.clear();
              });
            }
          },
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                technologies.map((tech) {
                  return Chip(
                    backgroundColor: CustomColor.gray_90,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      tech,
                      style: CustomText.Label_Heavy_XS_12.copyWith(
                        color: CustomColor.gray_10,
                      ),
                    ),
                    deleteIcon: Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        technologies.remove(tech);
                      });
                    },
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/views/personality/widgets/test_step_title.dart';
import 'package:teamfit/src/views/project/create/add_project_meeting_type_page.dart';
import 'package:teamfit/src/widgets/components/custom_progress_bar.dart';
import 'package:teamfit/src/widgets/components/custom_scroll_text_field.dart';
import 'package:teamfit/src/widgets/components/custom_text_field.dart';
import 'package:teamfit/src/widgets/components/input_box_item.dart';
import 'package:teamfit/src/widgets/components/next_step_bottom_button.dart';

class AddProjectInfoPage extends ConsumerStatefulWidget {
  const AddProjectInfoPage({super.key});

  @override
  ConsumerState<AddProjectInfoPage> createState() => _AddProjectInfoPageState();
}

class _AddProjectInfoPageState extends ConsumerState<AddProjectInfoPage> {
  ScrollController chatInputScrollController = ScrollController();
  bool _isPossible = false;

  final List<File> _images = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateIsPossible);
    _descriptionController.addListener(_updateIsPossible);
  }

  void _updateIsPossible() {
    setState(() {
      _isPossible =
          _titleController.text.trim().isNotEmpty &&
          _descriptionController.text.trim().isNotEmpty;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickMedia();

    if (pickedImage != null) {
      setState(() {
        _images.clear(); // 기존 이미지 제거
        _images.add(File(pickedImage.path));
      });
    }
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateIsPossible);
    _descriptionController.removeListener(_updateIsPossible);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
        appBar: AppBar(
      scrolledUnderElevation: 0,),
        body: Column(
          children: [
            CustomProgressBar(
              progress: (state.index).toDouble() / state.count.toDouble(),
            ),
            Expanded(
              child: ListView(
                controller: chatInputScrollController,
                children: [
                  TestStepTitle('02', '프로젝트에 대해 소개해주세요.'),

                  // SizedBox(height: 50),
                  _projectInfoInputColumn(),
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
        final vm = ref.read(addTeamProjectViewModel.notifier);
        vm.setProjectBasicInfo(
          projectImage: _images.isNotEmpty ? _images.first.path : null,
          title: _titleController.text,
          introduction: _descriptionController.text,
        );
        vm.nextStep(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProjectMeetingTypePage()),
        );
      },
    );
  }

  Column _projectInfoInputColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBoxItem(title: '프로젝트 이미지(선택)', body: _projectImageInputField()),
        InputBoxItem(title: '모집 제목', body: _projectTitleInputField()),
        InputBoxItem(
          title: '프로젝트 내용',
          body: _projectDescriptionInputField(),
          helpText: "현재 팀원이 있다면 그외 필요한 인원, 기술, 회의 방식 등\n자세히 작성할 수록 매칭률이 올라가요!",
        ),
      ],
    );
  }

  Widget _projectImageInputField() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _pickImage(),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: CustomColor.gray_95,
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  _images.isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(_images.first.path),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      )
                      : Icon(Icons.add, size: 40, color: CustomColor.gray_80),
            ),
          ),
        ],
      ),
    );
  }

  Column _projectTitleInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          textController: _titleController,
          maxLength: 20,
          hintText: "모집글 제목을 입력해주세요",
        ),
        // SizedBox(height: 5),
        // Text('${_titleController.text.length} / 20'), // 글자 수 표시
      ],
    );
  }

  Column _projectDescriptionInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomScrollTextField(
          scrollController: chatInputScrollController,
          descriptionController: _descriptionController,
          hintText: "프로젝트에 대해 설명해주세요",
          maxLength: 150,
        ),
        // SizedBox(height: 5),
        // Text('${_descriptionController.text.length} / 150'), // 글자 수 표시
      ],
    );
  }
}

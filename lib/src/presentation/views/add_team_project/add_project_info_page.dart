import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_meeting_type_page.dart';
import 'package:teamfit/src/presentation/views/add_team_project/widgets/add_project_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_scroll_text_field.dart';
import 'package:teamfit/src/presentation/widgets/custom_text_field.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectInfoPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddProjectInfoPage> createState() => _AddProjectInfoPageState();
}

class _AddProjectInfoPageState extends ConsumerState<AddProjectInfoPage> {
  ScrollController chatInputScrollController = ScrollController();
  bool _isPossible = true;

  List<File> _images = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        for (var element in pickedImages) {
          _images.add(File(element.path));
        }
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('팀 만들기', style: CustomText.Title_S)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: chatInputScrollController,
              children: [
                AddProjectStepTitle(
                  nowStep: '01',
                  allStep: '/03',
                  title: '프로젝트에 대해 소개해주세요.',
                ),
                SizedBox(height: 50),

                _projectInfoInputColumn(),
              ],
            ),
          ),
          _nextStepButton(context),
        ],
      ),
    );
  }

  NextStepBottomButton _nextStepButton(BuildContext context) {
    return NextStepBottomButton(
      title: '다음',
      isPossible: _isPossible,
      moveNext: () {
        final vm = ref.read(addTeamProjectViewModel.notifier);
        vm.setProjectInfo(_images, _titleController, _descriptionController);
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
        InputBoxItem(title: '프로젝트 제목', body: _projectTitleInputField()),
        InputBoxItem(title: '프로젝트 유형', body: _projectTitleInputField()),
        InputBoxItem(title: '프로젝트 소개', body: _projectDescriptionInputField()),
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
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Row(
            children:
                _images.isNotEmpty
                    ? _images.map((element) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: FileImage(element)),
                        ),
                      );
                    }).toList()
                    : [],
          ),
        ],
      ),
    );
  }

  Column _projectTitleInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(textController: _titleController, maxLength: 100),
        // SizedBox(height: 5),
        // Text('${_titleController.text.length} / 100'), // 글자 수 표시
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
        ),
        // SizedBox(height: 5),
        // Text('${_descriptionController.text.length} / 300'), // 글자 수 표시
      ],
    );
  }
}

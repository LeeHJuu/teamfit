import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/add_team_project/add_project_meeting_type_page.dart';
import 'package:teamfit/src/presentation/views/add_team_project/widgets/add_project_step_title.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectInfoPage extends StatefulWidget {
  @override
  State<AddProjectInfoPage> createState() => _AddProjectInfoPageState();
}

class _AddProjectInfoPageState extends State<AddProjectInfoPage> {
  ScrollController chatInputScrollController = ScrollController();
  bool _isPossible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('팀 만들기', style: CustomText.Title_S)),
      body: ListView(
        controller: chatInputScrollController,
        children: [
          AddProjectStepTitle(
            nowStep: '01',
            allStep: '/03',
            title: '프로젝트에 대해 소개해주세요.',
          ),
          // Spacer(),
          _projectInfoInputColumn(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectMeetingTypePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Column _projectInfoInputColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBoxItem(title: '프로젝트 이미지(선택)', body: Text('data')),
        InputBoxItem(title: '프로젝트 제목', body: _projectTitleInputField()),
        // InputBoxItem(title: '프로젝트 유형', body: Text('data')),
        InputBoxItem(title: '프로젝트 소개', body: _projectDescriptionInputField()),
      ],
    );
  }

  Column _projectTitleInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          // controller: _nameTextController,
          // textInputAction: TextInputAction.next,
          // onSubmitted: (value) {
          //   _updateIsPossible();
          // },
          decoration: InputDecoration(
            // hintText: 'ex) 냥냥이',
            // helperText: '서비스내에서 사용할 별명을 입력해주세요.',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        Text('data'),
      ],
    );
  }

  Column _projectDescriptionInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RawScrollbar(
          padding: EdgeInsets.only(right: 8, top: 10),
          trackVisibility: true,
          thumbVisibility: true,
          thumbColor: Colors.black,
          thickness: 5,
          radius: Radius.circular(10),
          controller: chatInputScrollController,
          child: TextField(
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.multiline,
          ),
        ),
        Text('data'),
      ],
    );
  }
}

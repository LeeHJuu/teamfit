import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/views/add_team_project/finish_add_project_page.dart';
import 'package:teamfit/src/presentation/views/add_team_project/widgets/add_project_step_title.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddProjectDesiredRolesPage extends StatefulWidget {
  @override
  State<AddProjectDesiredRolesPage> createState() =>
      _AddProjectDesiredRolesPageState();
}

class _AddProjectDesiredRolesPageState
    extends State<AddProjectDesiredRolesPage> {
  bool _isPossible = true;
  final tags = ['온도 50도 이상인 분 원해요', '온도 상관없어요', '경력자 원해요', '신입 환영해요'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('팀 만들기', style: CustomText.Title_S)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AddProjectStepTitle(
                  nowStep: '03',
                  allStep: '/03',
                  title: '모집 인원과 바라는 팀원',
                ),
                SizedBox(height: 50),
                _recruitMemberColumn(),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/signup/welcome_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserGoalPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserGoalPage> createState() => _AddUserGoalPageState();
}

class _AddUserGoalPageState extends ConsumerState<AddUserGoalPage> {
  bool _isPossible = false;

  List<String> userGoals = ['포트폴리오 제작', '사이드 프로젝트 진행', '공모전', '해커톤'];
  String selectedGoal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('지금 가장 집중하고 싶은\n활동은 무엇인가요?'),
          SizedBox(height: 50),
          _userGoalTagsBox(),
          NextStepBottomButton(
            title: '다음',
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _userGoalTagsBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 20, // 상하 간격
            crossAxisSpacing: 10, // 좌우 간격
            mainAxisExtent: 50,
          ),
          itemCount: userGoals.length, // 총 아이템 갯수
          itemBuilder: (context, index) {
            return CustomSelectButton(
              title: userGoals[index],
              isSelected: selectedGoal == userGoals[index],
              onPress: () {
                setState(() {
                  selectedGoal = userGoals[index];
                  _isPossible = selectedGoal.isNotEmpty;
                });
                final vm = ref.read(loginViewModel.notifier);
                vm.setUserGoal(selectedGoal);
              },
            );
          },
        ),
      ),
    );
  }
}

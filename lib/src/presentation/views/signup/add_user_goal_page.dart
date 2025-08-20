import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
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

  List<UserGoal> userGoals = UserGoal.values;
  UserGoal? selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('signin_page.user_goal.title'.tr()),
          SizedBox(height: 50),
          _userGoalTagsBox(),
          NextStepBottomButton(
            title: 'button_text.next'.tr(),
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
              title: userGoals[index].label,
              textAlign: 0,
              isSelected: selectedGoal == userGoals[index],
              onPress: () {
                setState(() {
                  selectedGoal = userGoals[index];
                  _isPossible = selectedGoal != null;
                });
                final vm = ref.read(loginViewModel.notifier);
                vm.setUserGoal(selectedGoal!);
              },
            );
          },
        ),
      ),
    );
  }
}

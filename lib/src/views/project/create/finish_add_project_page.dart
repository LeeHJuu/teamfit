import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/viewmodels/add_team_project_view_model.dart';
import 'package:teamfit/src/views/home/home_page.dart';
import 'package:teamfit/src/views/personality/widgets/test_step_title.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';

class FinishAddProjectPage extends ConsumerWidget {
  const FinishAddProjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TestStepTitle('완료', '팀 공고가 올라갔어요!'),
          Spacer(),
          NextStepBottomButton(
            title: '메인으로 가기',
            isPossible: true,
            moveNext: () async {
              final vm = ref.read(addTeamProjectViewModel.notifier);

              // 프로젝트를 Firebase에 저장
              await vm.completeProjectRegistration();

              // 홈 화면으로 이동
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/personality_test_view_model.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';

class PersonailtyTestPage extends ConsumerWidget {
  @override
  int count;
  String label;
  PersonailtyTestPage(this.count, this.label);

  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalityTestViewModel);
    final vm = ref.watch(personalityTestViewModel.notifier);

    final label = state.label;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomProgressBar(progress: 1),
          TestStepTitle(
            '${label.substring(0, label.lastIndexOf('.'))}.title'.tr(
              args: [label.substring(label.lastIndexOf('.') + 1)],
            ),
            '$label.question'.tr(),
          ),
          Column(
            children: [
              TestAnswerButton(label: label, index: 'D', vm: vm),
              TestAnswerButton(label: label, index: 'I', vm: vm),
              TestAnswerButton(label: label, index: 'S', vm: vm),
              TestAnswerButton(label: label, index: 'K', vm: vm),
            ],
          ),
        ],
      ),
    );
  }
}

class TestAnswerButton extends StatelessWidget {
  const TestAnswerButton({
    super.key,
    required this.label,
    required this.index,
    required this.vm,
  });

  final String label;
  final String index;
  final PersonalityTestViewModel vm;

  @override
  Widget build(BuildContext context) {
    return '$label.answers.$index'.tr() != '$label.answers.$index'
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                vm.nextQuestion(context, index); // index를 answer로 사용
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$label.answers.$index'.tr(),
                  style: CustomText.Label_Light_S,
                ),
              ),
            ),
          ),
        )
        : SizedBox();
  }
}

class TestStepTitle extends StatelessWidget {
  String sub;
  String title;

  TestStepTitle(this.sub, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sub,
            style: CustomText.Title_S.copyWith(color: CustomColor.gray_10),
          ),
          Text(
            title,
            style: CustomText.Headline_S.copyWith(color: CustomColor.gray_10),
          ),
        ],
      ),
    );
  }
}

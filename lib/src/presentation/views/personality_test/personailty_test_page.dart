import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/personality_test_view_model.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_answer_button.dart';
import 'package:teamfit/src/presentation/views/personality_test/widgets/test_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_progress_bar.dart';

class PersonailtyTestPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalityTestViewModel);
    final vm = ref.watch(personalityTestViewModel.notifier);

    final label = state.label;
    return PopScope(
      onPopInvoked: (didPop) {
        vm.removeLastResponse();
        return;
      },
      child: Scaffold(
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
            CustomProgressBar(
              progress: (state.index - 1).toDouble() / state.count.toDouble(),
            ),
            TestStepTitle(
              label.contains('default')
                  ? '${label.substring(0, label.lastIndexOf('.'))}.title'.tr(
                    args: [label.substring(label.lastIndexOf('.') + 1)],
                  )
                  : 'ss',
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
      ),
    );
  }
}

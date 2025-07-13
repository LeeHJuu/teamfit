import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/views/personality_test/personailty_test_page.dart';

class PersonalityTestState {
  int count;
  int all;
  String label;
  Map<String, int> result;

  PersonalityTestState({
    required this.count,
    required this.all,
    required this.label,
    required this.result,
  });
}

class PersonalityTestViewModel extends Notifier<PersonalityTestState> {
  @override
  PersonalityTestState build() {
    return PersonalityTestState(
      count: 1,
      all: 4,
      label: 'personality_test.default.1',
      result: {'D': 0, 'I': 0, 'S': 0, 'K': 0},
    );
  }

  void nextQuestion(BuildContext context, String answer) {
    final updatedResult = Map<String, int>.from(state.result);
    updatedResult.update(answer, (value) => value + 1, ifAbsent: () => 1);

    int nextCount = state.count + 1;
    String newLabel = determineLabel(updatedResult, nextCount);

    int newAll = state.all;
    if (newLabel.startsWith('personality_test.additional')) {
      newAll += 1;
    }

    state = PersonalityTestState(
      count: nextCount,
      all: newAll,
      label: newLabel,
      result: updatedResult,
    );

    // 페이지 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PersonailtyTestPage(nextCount, newLabel),
      ),
    );
  }

  String determineLabel(Map<String, int> result, int nextCount) {
    if (nextCount > state.all) {
      // 특정 조건에 따라 추가 label을 설정
      if (result.values.every((value) => value >= 2)) {
        return 'personality_test.additional.1';
      } else if (result.values.any((value) => value >= 3)) {
        return 'personality_test.additional.2';
      } else {
        return 'personality_test.additional.last';
      }
    } else {
      return 'personality_test.default.$nextCount';
    }
  }
}

final personalityTestViewModel =
    NotifierProvider<PersonalityTestViewModel, PersonalityTestState>(
      () => PersonalityTestViewModel(),
    );

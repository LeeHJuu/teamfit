import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/views/personality_test/personailty_test_page.dart';

class PersonalityTestState {
  int index;
  int count;
  String label;
  Map<String, int> result;
  List<Map<String, int>> responseHistory;

  PersonalityTestState({
    required this.index,
    required this.count,
    required this.label,
    required this.result,
    required this.responseHistory,
  });
}

class PersonalityTestViewModel extends Notifier<PersonalityTestState> {
  @override
  PersonalityTestState build() {
    return PersonalityTestState(
      index: 1,
      count: 6,
      label: 'personality_test.default.1',
      result: {'D': 0, 'I': 0, 'S': 0, 'K': 0},
      responseHistory: [],
    );
  }

  void nextQuestion(BuildContext context, String answer) {
    // 현재 응답 결과를 기록
    state.responseHistory.add(state.result);

    final updatedResult = Map<String, int>.from(state.result);
    updatedResult.update(answer, (value) => value + 1, ifAbsent: () => 1);

    int nextIndex = state.index + 1;
    String newLabel = determineLabel(updatedResult, nextIndex);

    int updatedCount = state.count;
    if (newLabel.startsWith('personality_test.additional')) {
      updatedCount += 1;
    }

    state = PersonalityTestState(
      index: nextIndex,
      count: updatedCount,
      label: newLabel,
      result: updatedResult,
      responseHistory: state.responseHistory, // 응답 기록 유지
    );
    // 페이지 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonailtyTestPage()),
    );
  }

  String determineLabel(Map<String, int> result, int nextCount) {
    if (nextCount > state.count) {
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

  void removeLastResponse() {
    if (state.responseHistory.isNotEmpty) {
      Map<String, int> lastResponse = state.responseHistory.removeLast();

      state = PersonalityTestState(
        index: state.index > 1 ? state.index - 1 : 1,
        count: state.count,
        label: determineLabel(
          lastResponse,
          state.index > 1 ? state.index - 1 : 1,
        ),
        result: lastResponse,
        responseHistory: state.responseHistory,
      );
    }
  }
}

final personalityTestViewModel =
    NotifierProvider<PersonalityTestViewModel, PersonalityTestState>(
      () => PersonalityTestViewModel(),
    );

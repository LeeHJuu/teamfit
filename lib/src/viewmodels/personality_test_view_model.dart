import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/provider.dart';
import 'package:teamfit/src/views/personality_test/personailty_test_page.dart';
import 'package:teamfit/src/views/personality_test/personality_result_page.dart';

class PersonalityTestState {
  int index;
  int count;
  String label;
  Map<String, int> result;
  List<PersonalityTestState> responseHistory; // 상태값 저장

  PersonalityTestState({
    required this.index,
    required this.count,
    required this.label,
    required this.result,
    required this.responseHistory,
  });
}

class PersonalityTestViewModel
    extends AutoDisposeNotifier<PersonalityTestState> {
  @override
  PersonalityTestState build() {
    return PersonalityTestState(
      index: 1,
      count: 4,
      label: 'personality_test.default.1',
      result: {'D': 0, 'I': 0, 'S': 0, 'C': 0},
      responseHistory: [],
    );
  }

  void nextQuestion(BuildContext context, String answer) {
    // 현재 응답 결과를 기록
    state.responseHistory.add(state);

    final updatedResult = Map<String, int>.from(state.result);
    updatedResult.update(answer, (value) => value + 1, ifAbsent: () => 1);
    print(updatedResult);

    int nextIndex = state.index + 1;
    String newLabel = determineLabel(updatedResult, nextIndex);

    if (newLabel.length <= 1) {
      finishTestAndSaveResult(context, newLabel);
      return;
    }

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

  void finishTestAndSaveResult(BuildContext context, String newLabel) {
    // String을 PersonalityType으로 변환 (결과 화면 표시용)
    PersonalityType personalityType;
    switch (newLabel) {
      case 'D':
        personalityType = PersonalityType.D;
        break;
      case 'I':
        personalityType = PersonalityType.I;
        break;
      case 'S':
        personalityType = PersonalityType.S;
        break;
      case 'C':
        personalityType = PersonalityType.C;
        break;
      default:
        personalityType = PersonalityType.D; // 기본값
    }

    // 테스트 완료 시 누적 점수로 저장 (백그라운드에서 실행)
    saveResultToUser().catchError((error) {
      print('Failed to save personality test result: $error');
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalityResultPage(personalityType),
      ),
    );
  }

  String determineLabel(Map<String, int> result, int nextIndex) {
    if (nextIndex > state.count) {
      // result에서 가장 큰 값과 그 값의 개수를 찾음
      int maxValue = result.values.reduce((a, b) => a > b ? a : b);
      List<String> keysWithMaxValue =
          result.keys.where((key) => result[key] == maxValue).toList();

      // 동일한 값이 여러 개 있는 경우
      if (keysWithMaxValue.length > 1) {
        // 동일한 값에 따라 다른 값을 리턴하는 로직
        if (keysWithMaxValue.contains('D') && keysWithMaxValue.contains('S')) {
          return 'personality_test.additional.1';
        } else if (keysWithMaxValue.contains('I') &&
            keysWithMaxValue.contains('C')) {
          return 'personality_test.additional.2';
        } else if (keysWithMaxValue.contains('D') &&
            keysWithMaxValue.contains('C')) {
          return 'personality_test.additional.3';
        } else if (keysWithMaxValue.contains('I') &&
            keysWithMaxValue.contains('C')) {
          return 'personality_test.additional.4';
        } else if (keysWithMaxValue.contains('D') &&
            keysWithMaxValue.contains('I')) {
          return 'personality_test.additional.5';
        } else if (keysWithMaxValue.contains('I') &&
            keysWithMaxValue.contains('S')) {
          return 'personality_test.additional.6';
        } else {
          return 'personality_test.additional.last';
        }
      } else {
        // 유일한 최대값인 경우
        return keysWithMaxValue.first;
      }
    } else {
      return 'personality_test.default.$nextIndex';
    }
  }

  void removeLastResponse() {
    if (state.responseHistory.isNotEmpty) {
      PersonalityTestState lastResponse = state.responseHistory.removeLast();

      // lastResponse의 값을 그대로 사용하여 상태를 복원
      state = lastResponse;
    }
  }

  void reset() {
    // build 메서드와 동일한 초기값으로 설정
    state = PersonalityTestState(
      index: 1,
      count: 4,
      label: 'personality_test.default.1',
      result: {'D': 0, 'I': 0, 'S': 0, 'C': 0},
      responseHistory: [],
    );
  }

  /// 성격 테스트 결과를 사용자 데이터로 저장
  /// 각 DISC 타입별 누적 점수를 Map 형태로 저장
  Future<void> saveResultToUser() async {
    // String 결과를 PersonalityType으로 변환
    final scores = <PersonalityType, int>{};
    for (final entry in state.result.entries) {
      switch (entry.key) {
        case 'D':
          scores[PersonalityType.D] = entry.value;
          break;
        case 'I':
          scores[PersonalityType.I] = entry.value;
          break;
        case 'S':
          scores[PersonalityType.S] = entry.value;
          break;
        case 'C':
          scores[PersonalityType.C] = entry.value;
          break;
      }
    }

    await ref.read(userServiceProvider).updatePersonalityScores(scores);
  }

  /// 하위 호환성을 위한 기존 메서드 (단일 타입 저장)
  /// @deprecated saveResultToUser()를 사용하세요
  Future<void> saveResultToUserLegacy(PersonalityType resultType) async {
    await ref.read(userServiceProvider).updatePersonalityType(resultType);
  }
}

final personalityTestViewModel = NotifierProvider.autoDispose<
  PersonalityTestViewModel,
  PersonalityTestState
>(() => PersonalityTestViewModel());

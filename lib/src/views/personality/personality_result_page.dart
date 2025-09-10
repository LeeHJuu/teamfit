import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/personality_test_view_model.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/home/home_page.dart';
import 'package:teamfit/src/views/personality/personailty_test_page.dart';
import 'package:teamfit/src/widgets/components/shadow_box_container.dart';

class PersonalityResultPage extends ConsumerWidget {
  final PersonalityType resultType;

  PersonalityResultPage(this.resultType);

  // resultType에 따른 데이터를 반환하는 getter
  Map<String, String> get _resultData {
    switch (resultType) {
      case PersonalityType.D:
        return {
          'highlighted': '불꽃 리더',
          'title': '목표를 향해 돌진하는\n불꽃 리더 네요!',
          'description':
              '불꽃 리더는 주도형 이에요\n내가 하면 다르다! 답답하면 내가 바로 뛰어들고\n끝까지 밀어붙이는 직진파.\n\'일단 해\'가 모토, 계획보다 실행먼저 型',
          'imagePath': 'assets/images/type_d.png',
        };
      case PersonalityType.I:
        return {
          'highlighted': '인싸력 만렙',
          'title': '어디서든 분위기 메이커\n인싸력 만렙 이네요!',
          'description':
              '인싸력 만렙은 사교형 이에요\n사람 만나는 게 취미, 웃음 폭탄 제조기!\n모임 주최도 말고,\n분위기 메이커로 다들 날 찾음',
          'imagePath': 'assets/images/type_i.png',
        };
      case PersonalityType.S:
        return {
          'highlighted': '평화주의자',
          'title': '조화와 균형을 추구하는\n평화주의자 네요!',
          'description':
              '평화주의자는 안정형 이에요\n변화보단 의숙한 게 좋고,\n갈등은 멀리하는 평화주의자.\n말은 적어도 책임은 확실한 조용한 히어로',
          'imagePath': 'assets/images/type_s.png',
        };
      case PersonalityType.C:
        return {
          'highlighted': '트리플 J',
          'title': '꼼꼼한 계획 없이 못 사는\n트리플 J 네요!',
          'description':
              '트리플 J는 신중형 이에요\n완벽주의 플래너, 디테일 강맥.\n\'왜?\' \'어떻게?\'를 무한반복하는 문제 해결사',
          'imagePath': 'assets/images/type_c.png',
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(loginViewModel).value;
    final nickname = userData?.nickname ?? '사용자';

    return PopScope(
      onPopInvoked: (didPop) {
        final vm = ref.read(personalityTestViewModel.notifier);
        vm.removeLastResponse();
        return;
      },
      child: Stack(
        children: [
          _background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: [
                _resultCard(nickname),
                _descriptionText(),
                Spacer(),
                _bottomButtons(ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Stack(
        children: [
          Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          Container(color: Colors.white70),
        ],
      ),
    );
  }

  Widget _resultCard(String nickname) {
    return ShadowBoxContainer(
      // padding: EdgeInsets.all(24),
      // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          _titleSection(nickname),
          SizedBox(height: 32),
          _characterImage(),
        ],
      ),
    );
  }

  Widget _titleSection(String nickname) {
    return Column(
      children: [
        Text(
          '$nickname님은',
          style: CustomText.Title_L_22.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        _buildRichTitle(),
      ],
    );
  }

  Widget _buildRichTitle() {
    final highlighted = _resultData['highlighted']!;
    final title = _resultData['title']!;

    List<InlineSpan> spans = [];
    String remainingText = title;

    // 하이라이트 키워드 찾기
    int highlightIndex = remainingText.indexOf(highlighted);

    if (highlightIndex != -1) {
      // 하이라이트 이전 텍스트
      if (highlightIndex > 0) {
        spans.add(
          TextSpan(
            text: remainingText.substring(0, highlightIndex),
            style: CustomText.Title_L_22.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        );
      }

      // 하이라이트 텍스트를 Container로 감싸기
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _getHighlightColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              highlighted,
              style: CustomText.Title_L_22.copyWith(color: Colors.black87),
            ),
          ),
        ),
      );

      // 하이라이트 이후 텍스트
      String afterHighlight = remainingText.substring(
        highlightIndex + highlighted.length,
      );
      if (afterHighlight.isNotEmpty) {
        spans.add(
          TextSpan(
            text: afterHighlight,
            style: CustomText.Title_L_22.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        );
      }
    } else {
      // 하이라이트를 찾지 못한 경우 전체 텍스트
      spans.add(TextSpan(text: title, style: CustomText.Title_L_22));
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }

  Widget _characterImage() {
    return Image.asset(
      _resultData['imagePath']!,
      fit: BoxFit.contain,
      width: double.infinity - 80,
    );
  }

  Widget _descriptionText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: _buildRichDescription(),
    );
  }

  Widget _buildRichDescription() {
    final description = _resultData['description']!;
    final boldKeywords = _getBoldKeywords();

    List<TextSpan> spans = [];
    String remainingText = description;

    while (remainingText.isNotEmpty) {
      int earliestIndex = remainingText.length;
      String foundKeyword = '';

      // 가장 먼저 나오는 키워드 찾기
      for (String keyword in boldKeywords) {
        int index = remainingText.indexOf(keyword);
        if (index != -1 && index < earliestIndex) {
          earliestIndex = index;
          foundKeyword = keyword;
        }
      }

      if (foundKeyword.isNotEmpty) {
        // 키워드 이전 텍스트 추가
        if (earliestIndex > 0) {
          spans.add(
            TextSpan(
              text: remainingText.substring(0, earliestIndex),
              style: CustomText.Body_Light_M_14.copyWith(color: Colors.black87),
            ),
          );
        }

        // 볼드 키워드 추가
        spans.add(
          TextSpan(
            text: foundKeyword,
            style: CustomText.Body_Heavy_M_14.copyWith(color: Colors.black87),
          ),
        );

        // 남은 텍스트 업데이트
        remainingText = remainingText.substring(
          earliestIndex + foundKeyword.length,
        );
      } else {
        // 더 이상 키워드가 없으면 남은 텍스트 모두 추가
        spans.add(
          TextSpan(
            text: remainingText,
            style: CustomText.Body_Light_M_14.copyWith(color: Colors.black87),
          ),
        );
        break;
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }

  List<String> _getBoldKeywords() {
    switch (resultType) {
      case PersonalityType.D:
        return ['불꽃 리더', '주도형'];
      case PersonalityType.I:
        return ['인싸력 만렙', '사교형'];
      case PersonalityType.S:
        return ['평화주의자', '안정형'];
      case PersonalityType.C:
        return ['트리플 J', '신중형'];
    }
  }

  Widget _bottomButtons(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _retakeTest(ref),
              child: Text(
                '테스트 다시하기',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: () => _goToTeamFinding(ref),
              child: Text(
                '팀 찾으러 가기',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getHighlightColor() {
    switch (resultType) {
      case PersonalityType.D:
        return Colors.orange;
      case PersonalityType.I:
        return Colors.yellow[700]!;
      case PersonalityType.S:
        return Colors.green;
      case PersonalityType.C:
        return Colors.blue[400]!;
    }
  }

  void _retakeTest(WidgetRef ref) {
    final vm = ref.read(personalityTestViewModel.notifier);
    vm.reset();
    Navigator.pushAndRemoveUntil(
      ref.context,
      MaterialPageRoute(builder: (context) => PersonailtyTestPage()),
      (route) => false,
    );
  }

  void _goToTeamFinding(WidgetRef ref) async {
    try {
      final vm = ref.read(personalityTestViewModel.notifier);
      await vm.saveResultToUser();

      Navigator.pushAndRemoveUntil(
        ref.context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: Text('결과 저장에 실패했습니다. 다시 시도해 주세요.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      print('성향테스트 결과 저장 실패: $error');
    }
  }
}

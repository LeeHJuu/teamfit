import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/personality_test_view_model.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/personailty_test_page.dart';

class PersonalityResultPage extends StatelessWidget {
  final PersonalityType resultType;

  PersonalityResultPage(this.resultType);

  // resultType에 따른 데이터를 반환하는 getter
  Map<String, String> get _resultData {
    switch (resultType) {
      case PersonalityType.D:
        return {
          'title': 'D 타입 제목\nd\nd',
          'description': 'D 타입에 대한 설명입니다.\nd\nd',
          'imagePath': 'assets/images/type_d.png',
        };
      case PersonalityType.I:
        return {
          'title': 'I 타입 제목\nd\nd',
          'description': 'I 타입에 대한 설명입니다.\nd\nd',
          'imagePath': 'assets/images/type_i.png',
        };
      case PersonalityType.S:
        return {
          'title': 'S 타입 제목\nd\nd',
          'description': 'S 타입에 대한 설명입니다.\nd\nd',
          'imagePath': 'assets/images/type_s.png',
        };
      case PersonalityType.C:
        return {
          'title': 'C 타입 제목\nd\nd',
          'description': 'C 타입에 대한 설명입니다.\nd\nd',
          'imagePath': 'assets/images/type_c.png',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: Column(
            children: [
              _resultCard(),
              _descriptionText(),
              Spacer(),
              _bottomButtons(),
            ],
          ),
        ),
      ],
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

  Widget _resultCard() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _resultData['title']!,
            textAlign: TextAlign.center,
            style: CustomText.Title_L_22,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          Image.asset(_resultData['imagePath']!),
        ],
      ),
    );
  }

  Widget _descriptionText() {
    return Text(_resultData['description']!, style: CustomText.Body_Light_M_14);
  }

  Widget _bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
      child: Consumer(
        builder: (context, ref, child) {
          return Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final vm = ref.read(personalityTestViewModel.notifier);
                    vm.reset(); // 상태 초기화
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonailtyTestPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text('테스트 다시하기'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    final vm = ref.read(personalityTestViewModel.notifier);
                    await vm.saveResultToUser(
                      resultType,
                    ); // 결과를 유저 정보에 저장 (비동기 처리)
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  },
                  child: Text('팀 찾으러 가기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

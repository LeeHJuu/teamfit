import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class PersonalityResultPage extends StatelessWidget {
  String resultType;
  PersonalityResultPage(this.resultType);

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
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'data\ndd\ndd',
            textAlign: TextAlign.center,
            style: CustomText.Title_L_22,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          Image.asset('assets/images/main_img.png'),
        ],
      ),
    );
  }

  Widget _descriptionText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text('data\ndd\ndd\ndd', style: CustomText.Body_Light_M_14),
    );
  }

  Widget _bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(onPressed: () {}, child: Text('data')),
          ),
          SizedBox(width: 10),
          Expanded(child: FilledButton(onPressed: () {}, child: Text('data'))),
        ],
      ),
    );
  }
}

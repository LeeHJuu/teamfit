import 'package:flutter/material.dart';

class TeatSearchTap extends StatelessWidget {
  const TeatSearchTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(hintText: '찾으시는 팀프로젝트를 입력해주세요.')),
        Row(children: [Text('머시기 태그들')]),
      ],
    );
  }
}

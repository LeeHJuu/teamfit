import 'package:flutter/material.dart';
import 'package:teamfit/src/widgets/custom_search_field.dart';

class TeamSearchTap extends StatelessWidget {
  const TeamSearchTap({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomSearchField(
            textController: searchController,
            hintText: '찾으시는 팀프로젝트를 입력해주세요.',
            onSearch: () {
              // 검색 기능 구현
              print('검색 버튼 클릭됨');
            },
          ),
        ),
        SizedBox(height: 8.0), // 간격 추가
        Text('여기에 태그들..'),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/widgets/custom_search_field.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/project_filter_chips.dart';

class TeamSearchTap extends StatelessWidget {
  const TeamSearchTap({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
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
        ProjectFilterChips(),
      ],
    );
  }
}

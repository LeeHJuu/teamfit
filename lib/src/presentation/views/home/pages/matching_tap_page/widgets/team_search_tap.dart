import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class TeatSearchTap extends StatelessWidget {
  const TeatSearchTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hint: Text(
                        '찾으시는 팀프로젝트를 입력해주세요.',
                        style: CustomText.Body_Light_XS_12,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      // filled: true,
                      // fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // 검색 기능 구현
                    print('검색 버튼 클릭됨');
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0), // 간격 추가
          Text('여기에 태그들..'),
        ],
      ),
    );
  }
}

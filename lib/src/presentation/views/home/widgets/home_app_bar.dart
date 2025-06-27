import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text('로고'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('12월 24일', style: CustomText.Title_S),
              Text('스터디 n개 운영중!', style: CustomText.Body_Light_XS),
            ],
          ),
        ],
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.alarm))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

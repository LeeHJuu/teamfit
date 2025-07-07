import 'package:easy_localization/easy_localization.dart';
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
              Text(
                'home_page.active_project_count'.tr(args: ['5']),
                style: CustomText.Body_Light_XS,
              ),
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

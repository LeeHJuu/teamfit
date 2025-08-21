import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/home_view_model.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModel);
    return AppBar(
      backgroundColor: state != 0 ? CustomColor.primary_60 : null,
      title: Row(
        children: [
          // Text('로고'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image.asset('assets/images/app_logo.png', width: 50),
          ),
          state == 0
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('12월 24일', style: CustomText.Title_S_18),
                  Text(
                    'home_page.active_project_count'.tr(args: ['5']),
                    style: CustomText.Body_Light_XS_12,
                  ),
                ],
              )
              : SizedBox(),
        ],
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.alarm))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

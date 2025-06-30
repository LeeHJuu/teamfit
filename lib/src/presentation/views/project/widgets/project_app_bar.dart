import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [Text('무슨팀'), Text('D-30', style: CustomText.Body_Light_XS)],
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.alarm))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

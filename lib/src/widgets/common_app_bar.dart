import 'package:flutter/material.dart';
import '../config/theme/custom_color.dart';
import '../config/theme/custom_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClosePressed;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.onClosePressed,
    this.actions,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? CustomColor.primary_60,
      elevation: 0,
      leading:
          onBackPressed != null
              ? IconButton(
                onPressed: onBackPressed,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              )
              : null,
      title: Text(
        title,
        style: CustomText.Title_S_18.copyWith(color: Colors.white),
      ),
      actions: [
        if (onClosePressed != null)
          IconButton(
            onPressed: onClosePressed,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

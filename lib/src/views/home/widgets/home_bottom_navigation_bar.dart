import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/viewmodels/home_view_model.dart';

class HomeBottomNavigationBar extends ConsumerWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModel);
    final vm = ref.read(homeViewModel.notifier);

    return BottomNavigationBar(
      currentIndex: state,
      onTap: vm.onIndexChanged,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: 'navigation_bar.home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: 'navigation_bar.matching'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: 'navigation_bar.my'.tr(),
        ),
      ],
    );
  }
}

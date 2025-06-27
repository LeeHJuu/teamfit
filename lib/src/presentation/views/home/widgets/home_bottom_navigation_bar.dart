import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/home_view_model.dart';

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
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '홈(팀)'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '매칭'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '마이'),
      ],
    );
  }
}

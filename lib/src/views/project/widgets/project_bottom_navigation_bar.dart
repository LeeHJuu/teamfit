import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/viewmodels/project_view_model.dart';

class ProjectBottomNavigationBar extends ConsumerWidget {
  const ProjectBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(projectViewModel.notifier);

    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (value) {
        vm.onIndexChanged(value, context);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.amber,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      selectedIconTheme: IconThemeData(size: 24),
      unselectedIconTheme: IconThemeData(size: 24),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '채팅'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '달력'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '팀원'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '설정'),
      ],
    );
  }
}

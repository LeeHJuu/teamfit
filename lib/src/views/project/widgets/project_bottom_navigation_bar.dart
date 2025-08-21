import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/viewmodels/project_view_model.dart';

class ProjectBottomNavigationBar extends ConsumerWidget {
  const ProjectBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectViewModel);
    final vm = ref.read(projectViewModel.notifier);

    return BottomNavigationBar(
      currentIndex: state,
      onTap: (value) {
        vm.onIndexChanged(value, context);
      },
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.amber,
      unselectedItemColor: Colors.amber,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '채팅'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '달력'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '팀원'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '설정'),
      ],
    );
  }
}

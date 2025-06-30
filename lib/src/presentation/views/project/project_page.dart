import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/project_view_model.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_app_bar.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_bottom_navigation_bar.dart';

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectViewModel);
    return Scaffold(
      appBar: ProjectAppBar(),
      body: Center(child: Text('data')),
      bottomNavigationBar: ProjectBottomNavigationBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/project_view_model.dart';
import 'package:teamfit/src/presentation/views/project/pages/project_callendar_tap_page/project_callendar_tap_page.dart';
import 'package:teamfit/src/presentation/views/project/pages/project_chat_tap_page/project_chat_tap_page.dart';
import 'package:teamfit/src/presentation/views/project/pages/project_home_tap_page/project_home_tap_page.dart';
import 'package:teamfit/src/presentation/views/project/pages/project_member_tap_page/project_member_tap_page.dart';
import 'package:teamfit/src/presentation/views/project/pages/project_setting_tap_page/project_setting_tap_page.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_app_bar.dart';
import 'package:teamfit/src/presentation/views/project/widgets/project_bottom_navigation_bar.dart';

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectViewModel);
    return Scaffold(
      appBar: ProjectAppBar(),
      body: IndexedStack(
        index: state,
        children: [
          ProjectHomeTapPage(),
          ProjectChatTapPage(),
          ProjectCallendarTapPage(),
          ProjectMemberTapPage(),
          ProjectSettingTapPage(),
        ],
      ),
      bottomNavigationBar: ProjectBottomNavigationBar(),
    );
  }
}

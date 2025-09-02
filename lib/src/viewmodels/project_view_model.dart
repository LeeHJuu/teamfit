import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/views/project/detail/schedule/project_calendar_page.dart';
import 'package:teamfit/src/views/project/detail/chat/project_chat_tap_page.dart';
import 'package:teamfit/src/views/project/detail/members/project_member_tap_page.dart';
import 'package:teamfit/src/views/project/detail/project_page.dart';
import 'package:teamfit/src/views/project/detail/settings/project_setting_tap_page.dart';

class ProjectViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void onIndexChanged(int newIndex, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (newIndex) {
            case 0:
              return ProjectChatTapPage(projectId: 'projectId');
            case 1:
              return ProjectCalendarPage();
            case 2:
              return ProjectMemberTapPage();
            case 3:
              return ProjectSettingTapPage();
            default:
              return ProjectPage();
          }
        },
      ),
    );
  }
}

final projectViewModel = NotifierProvider<ProjectViewModel, int>(
  () => ProjectViewModel(),
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/views/project/project_page.dart';
import 'package:teamfit/src/views/project_callendar_tap_page/project_callendar_tap_page.dart';
import 'package:teamfit/src/views/project_chat_tap_page/project_chat_tap_page.dart';
import 'package:teamfit/src/views/project_member_tap_page/project_member_tap_page.dart';
import 'package:teamfit/src/views/project_setting_tap_page/project_setting_tap_page.dart';

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
              return ProjectChatTapPage();
            case 1:
              return ProjectCallendarTapPage();
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

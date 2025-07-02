import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/views/project/project_page.dart';
import 'package:teamfit/src/presentation/views/project_chat/project_chat_page.dart';

class ProjectViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void onIndexChanged(int newIndex, BuildContext context) {
    state = newIndex;
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         switch (newIndex) {
    //           case 0:
    //             return ProjectChatPage();
    //           default:
    //             return ProjectPage();
    //         }
    //       },
    //     ),
    //   );
  }
}

final projectViewModel = NotifierProvider<ProjectViewModel, int>(
  () => ProjectViewModel(),
);

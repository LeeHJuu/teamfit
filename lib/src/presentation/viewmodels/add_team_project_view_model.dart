import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/domain/models/project_recruit_info.dart';

class AddTeamProjectViewModel extends Notifier<ProjectRecruitInfo?> {
  @override
  ProjectRecruitInfo? build() {
    return null;
  }

  void setProjectInfo(
    List<File> images,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    state = ProjectRecruitInfo(
      projectId: 'projectId',
      title: titleController.text.trim(),
      introduction: descriptionController.text.trim(),
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      meetingType: 0,
      meetingDays: [],
      meetingTime: '',
      desiredRoles: {},
      preferredMemberTraits: [],
      additionalInfo: '',
    );
  }

  void setProjectDesiredRoles() {}

  void setProjectMeetingType() {}
}

final addTeamProjectViewModel =
    NotifierProvider<AddTeamProjectViewModel, ProjectRecruitInfo?>(
      () => AddTeamProjectViewModel(),
    );

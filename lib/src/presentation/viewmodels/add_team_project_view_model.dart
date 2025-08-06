import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/domain/models/project_recruit_info.dart';

class AddTeamProjectState {
  final ProjectRecruitInfo? projectInfo;
  final int index;
  final int count;
  final List<AddTeamProjectState> stepHistory; // 단계 히스토리 저장

  AddTeamProjectState({
    this.projectInfo,
    required this.index,
    required this.count,
    required this.stepHistory,
  });

  double get progress => index / count;
}

class AddTeamProjectViewModel extends Notifier<AddTeamProjectState> {
  @override
  AddTeamProjectState build() {
    return AddTeamProjectState(
      projectInfo: null,
      index: 1,
      count: 4, // 목표 선택, 프로젝트 정보, 협업 방식, 모집 인원
      stepHistory: [],
    );
  }

  void setProjectInfo(
    List<File> images,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    final projectInfo = ProjectRecruitInfo(
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
    );

    state = AddTeamProjectState(
      projectInfo: projectInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  void setProjectDesiredRoles() {}

  void setProjectMeetingType() {}

  void nextStep(BuildContext context) {
    // 현재 상태를 히스토리에 저장
    state.stepHistory.add(state);

    int nextIndex = state.index + 1;

    state = AddTeamProjectState(
      projectInfo: state.projectInfo,
      index: nextIndex,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  void setCount(int count) {
    state = AddTeamProjectState(
      projectInfo: state.projectInfo,
      index: state.index,
      count: count,
      stepHistory: state.stepHistory,
    );
  }

  void goBack() {
    if (state.stepHistory.isNotEmpty) {
      AddTeamProjectState previousState = state.stepHistory.removeLast();

      state = previousState;
    }
  }
}

final addTeamProjectViewModel =
    NotifierProvider<AddTeamProjectViewModel, AddTeamProjectState>(
      () => AddTeamProjectViewModel(),
    );

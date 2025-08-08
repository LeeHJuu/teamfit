import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/data/models/project_recruit_info_dto.dart';
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
      count: 5, // 목표 선택, 프로젝트 정보, 팀 정보, 모집 팀원, 선호 팀원
      stepHistory: [],
    );
  }

  // 프로젝트 목표 설정
  void setProjectGoal(int projectGoal) {
    final currentInfo = state.projectInfo;
    final updatedInfo =
        currentInfo?.copyWith(projectGoal: projectGoal) ??
        ProjectRecruitInfo(
          title: '',
          introduction: '',
          teamName: '',
          duration: ProjectDuration.oneToSixMonths,
          meetingType: MeetingType.online,
          recruitMembers: [],
          passionLevel: PassionLevel.any,
          experienceLevel: ExperienceLevel.fresh,
          projectGoal: projectGoal,
        );

    state = AddTeamProjectState(
      projectInfo: updatedInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  // 프로젝트 이미지, 모집글 제목, 프로젝트 소개글 설정
  void setProjectBasicInfo({
    String? projectImage,
    required String title,
    required String introduction,
  }) {
    final currentInfo = state.projectInfo;
    final updatedInfo =
        currentInfo?.copyWith(
          projectImage: projectImage,
          title: title,
          introduction: introduction,
        ) ??
        ProjectRecruitInfo(
          title: title,
          introduction: introduction,
          teamName: '',
          duration: ProjectDuration.oneToSixMonths,
          meetingType: MeetingType.online,
          recruitMembers: [],
          passionLevel: PassionLevel.any,
          experienceLevel: ExperienceLevel.fresh,
          projectGoal: 1, // 기본값: 포트폴리오 제작
          projectImage: projectImage,
        );

    state = AddTeamProjectState(
      projectInfo: updatedInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  // 팀 이름, 프로젝트 기간, 회의 방식 설정
  void setTeamInfo({
    required String teamName,
    required ProjectDuration duration,
    required MeetingType meetingType,
  }) {
    final currentInfo = state.projectInfo;
    final updatedInfo =
        currentInfo?.copyWith(
          teamName: teamName,
          duration: duration,
          meetingType: meetingType,
        ) ??
        ProjectRecruitInfo(
          title: '',
          introduction: '',
          teamName: teamName,
          duration: duration,
          meetingType: meetingType,
          recruitMembers: [],
          passionLevel: PassionLevel.any,
          experienceLevel: ExperienceLevel.fresh,
          projectGoal: 1, // 기본값: 포트폴리오 제작
        );

    state = AddTeamProjectState(
      projectInfo: updatedInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  // 모집 팀원 설정
  void setRecruitMembers(List<RecruitMember> recruitMembers) {
    final currentInfo = state.projectInfo;
    final updatedInfo =
        currentInfo?.copyWith(recruitMembers: recruitMembers) ??
        ProjectRecruitInfo(
          title: '',
          introduction: '',
          teamName: '',
          duration: ProjectDuration.oneToSixMonths,
          meetingType: MeetingType.online,
          recruitMembers: recruitMembers,
          passionLevel: PassionLevel.any,
          experienceLevel: ExperienceLevel.fresh,
          projectGoal: 1, // 기본값: 포트폴리오 제작
        );

    state = AddTeamProjectState(
      projectInfo: updatedInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

  // 선호 팀원 온도, 선호 팀원 경력 설정
  void setPreferredMemberInfo({
    required PassionLevel passionLevel,
    required ExperienceLevel experienceLevel,
  }) {
    final currentInfo = state.projectInfo;
    final updatedInfo =
        currentInfo?.copyWith(
          passionLevel: passionLevel,
          experienceLevel: experienceLevel,
        ) ??
        ProjectRecruitInfo(
          title: '',
          introduction: '',
          teamName: '',
          duration: ProjectDuration.oneToSixMonths,
          meetingType: MeetingType.online,
          recruitMembers: [],
          passionLevel: passionLevel,
          experienceLevel: experienceLevel,
          projectGoal: 1, // 기본값: 포트폴리오 제작
        );

    state = AddTeamProjectState(
      projectInfo: updatedInfo,
      index: state.index,
      count: state.count,
      stepHistory: state.stepHistory,
    );
  }

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

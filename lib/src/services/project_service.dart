import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/project_recruit_info.dart';
import '../models/project_data.dart';
import '../models/schedule_data.dart';
import '../models/task_data.dart';
import '../models/user_data.dart';
import '../config/enums.dart';

class ProjectService {
  ProjectService(this._firestore);
  final FirebaseFirestore _firestore;

  // 프로젝트 CRUD (모집글 등록 = 프로젝트 생성)
  Future<String> createProject(ProjectRecruitInfo projectInfo) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      final projectRef = _firestore.collection('projects').doc();
      final now = DateTime.now();

      final projectData = ProjectData(
        id: projectRef.id,
        title: projectInfo.title,
        description: projectInfo.introduction,
        leaderId: user.uid,
        memberIds: [user.uid], // 팀장은 기본적으로 멤버에 포함
        recruitInfo: projectInfo,
        status: ProjectStatus.recruiting,
        createdAt: now,
        updatedAt: now,
      );

      await projectRef.set(projectData.toJson());

      // 사용자의 projectIds에 추가
      await _firestore.collection('users').doc(user.uid).update({
        'projectIds': FieldValue.arrayUnion([projectRef.id]),
      });

      return projectRef.id;
    } catch (e) {
      print('ProjectService::createProject $e');
      throw Exception('Failed to create project: $e');
    }
  }

  Future<ProjectData?> getProject(String projectId) async {
    try {
      final projectDoc =
          await _firestore.collection('projects').doc(projectId).get();

      if (!projectDoc.exists) {
        return null;
      }

      return ProjectData.fromJson(projectDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('ProjectService::getProject $e');
      throw Exception('Failed to get project: $e');
    }
  }

  Future<void> updateProject(String projectId, ProjectData project) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final currentProject = await getProject(projectId);
      if (currentProject == null || currentProject.leaderId != user.uid) {
        throw Exception('Only project leader can update project.');
      }

      project.updatedAt = DateTime.now();
      await _firestore
          .collection('projects')
          .doc(projectId)
          .update(project.toJson());
    } catch (e) {
      print('ProjectService::updateProject $e');
      throw Exception('Failed to update project: $e');
    }
  }

  // 팀장만 가능
  Future<void> completeProject(String projectId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final project = await getProject(projectId);
      if (project == null || project.leaderId != user.uid) {
        throw Exception('Only project leader can complete project.');
      }

      await _firestore.collection('projects').doc(projectId).update({
        'status': ProjectStatus.completed.name,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::completeProject $e');
      throw Exception('Failed to complete project: $e');
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final project = await getProject(projectId);
      if (project == null || project.leaderId != user.uid) {
        throw Exception('Only project leader can delete project.');
      }

      // 모든 멤버의 projectIds에서 제거
      final batch = _firestore.batch();

      for (String memberId in project.memberIds) {
        final userRef = _firestore.collection('users').doc(memberId);
        batch.update(userRef, {
          'projectIds': FieldValue.arrayRemove([projectId]),
        });
      }

      // 프로젝트 삭제
      final projectRef = _firestore.collection('projects').doc(projectId);
      batch.delete(projectRef);

      await batch.commit();
    } catch (e) {
      print('ProjectService::deleteProject $e');
      throw Exception('Failed to delete project: $e');
    }
  }

  // 검색 및 필터링
  Future<List<ProjectData>> searchProjects({
    String? keyword,
    List<String>? techStack,
    String? duration,
    String? meetingType,
  }) async {
    try {
      Query query = _firestore
          .collection('projects')
          .where('status', isEqualTo: ProjectStatus.recruiting.name)
          .orderBy('createdAt', descending: true);

      final querySnapshot = await query.get();
      List<ProjectData> projects =
          querySnapshot.docs
              .map(
                (doc) =>
                    ProjectData.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList();

      // 클라이언트 사이드 필터링
      if (keyword != null && keyword.isNotEmpty) {
        projects =
            projects
                .where(
                  (project) =>
                      project.title.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ) ||
                      project.description.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ),
                )
                .toList();
      }

      if (duration != null) {
        projects =
            projects
                .where(
                  (project) => project.recruitInfo.duration?.name == duration,
                )
                .toList();
      }

      if (meetingType != null) {
        projects =
            projects
                .where(
                  (project) =>
                      project.recruitInfo.meetingType?.name == meetingType,
                )
                .toList();
      }

      return projects;
    } catch (e) {
      print('ProjectService::searchProjects $e');
      throw Exception('Failed to search projects: $e');
    }
  }

  // 팀 관리 (팀장 권한)
  Future<void> inviteMembers(String projectId, List<String> userIds) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final project = await getProject(projectId);
      if (project == null || project.leaderId != user.uid) {
        throw Exception('Only project leader can invite members.');
      }

      // TODO: 실제 링크 전송 로직 구현 (푸시 알림, 이메일 등)
      print('Inviting users: $userIds to project: $projectId');
    } catch (e) {
      print('ProjectService::inviteMembers $e');
      throw Exception('Failed to invite members: $e');
    }
  }

  // 프로젝트 지원
  Future<void> applyToProject(String projectId, String userId) async {
    try {
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      if (project.status != ProjectStatus.recruiting) {
        throw Exception('Project is not recruiting.');
      }

      if (project.memberIds.contains(userId) ||
          project.applicantIds.contains(userId)) {
        throw Exception('User already applied or is a member.');
      }

      await _firestore.collection('projects').doc(projectId).update({
        'applicantIds': FieldValue.arrayUnion([userId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::applyToProject $e');
      throw Exception('Failed to apply to project: $e');
    }
  }

  // 지원자 수락 (팀장 권한)
  Future<void> acceptApplicant(String projectId, String userId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final project = await getProject(projectId);
      if (project == null || project.leaderId != user.uid) {
        throw Exception('Only project leader can accept applicants.');
      }

      if (!project.applicantIds.contains(userId)) {
        throw Exception('User is not an applicant.');
      }

      final batch = _firestore.batch();

      // 프로젝트에서 지원자를 멤버로 이동
      final projectRef = _firestore.collection('projects').doc(projectId);
      batch.update(projectRef, {
        'memberIds': FieldValue.arrayUnion([userId]),
        'applicantIds': FieldValue.arrayRemove([userId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      // 사용자의 projectIds에 추가
      final userRef = _firestore.collection('users').doc(userId);
      batch.update(userRef, {
        'projectIds': FieldValue.arrayUnion([projectId]),
      });

      await batch.commit();
    } catch (e) {
      print('ProjectService::acceptApplicant $e');
      throw Exception('Failed to accept applicant: $e');
    }
  }

  // 지원자 거절 (팀장 권한)
  Future<void> rejectApplicant(String projectId, String userId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 팀장 권한 확인
      final project = await getProject(projectId);
      if (project == null || project.leaderId != user.uid) {
        throw Exception('Only project leader can reject applicants.');
      }

      if (!project.applicantIds.contains(userId)) {
        throw Exception('User is not an applicant.');
      }

      await _firestore.collection('projects').doc(projectId).update({
        'applicantIds': FieldValue.arrayRemove([userId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::rejectApplicant $e');
      throw Exception('Failed to reject applicant: $e');
    }
  }

  Future<void> joinProject(String projectId, String userId) async {
    try {
      // 초대 링크를 통한 참여 로직
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      if (project.status != ProjectStatus.recruiting) {
        throw Exception('Project is not recruiting.');
      }

      if (project.memberIds.contains(userId)) {
        throw Exception('User is already a member.');
      }

      final batch = _firestore.batch();

      // 프로젝트 멤버에 추가
      final projectRef = _firestore.collection('projects').doc(projectId);
      batch.update(projectRef, {
        'memberIds': FieldValue.arrayUnion([userId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      // 사용자의 projectIds에 추가
      final userRef = _firestore.collection('users').doc(userId);
      batch.update(userRef, {
        'projectIds': FieldValue.arrayUnion([projectId]),
      });

      await batch.commit();
    } catch (e) {
      print('ProjectService::joinProject $e');
      throw Exception('Failed to join project: $e');
    }
  }

  Future<void> leaveProject(String projectId, String userId) async {
    try {
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      if (project.leaderId == userId) {
        throw Exception(
          'Project leader cannot leave project. Transfer leadership first.',
        );
      }

      if (!project.memberIds.contains(userId)) {
        throw Exception('User is not a member.');
      }

      final batch = _firestore.batch();

      // 프로젝트 멤버에서 제거
      final projectRef = _firestore.collection('projects').doc(projectId);
      batch.update(projectRef, {
        'memberIds': FieldValue.arrayRemove([userId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      // 사용자의 projectIds에서 제거
      final userRef = _firestore.collection('users').doc(userId);
      batch.update(userRef, {
        'projectIds': FieldValue.arrayRemove([projectId]),
      });

      await batch.commit();
    } catch (e) {
      print('ProjectService::leaveProject $e');
      throw Exception('Failed to leave project: $e');
    }
  }

  Future<List<UserData>> getProjectMembers(String projectId) async {
    try {
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      List<UserData> members = [];
      for (String memberId in project.memberIds) {
        final userDoc =
            await _firestore.collection('users').doc(memberId).get();
        if (userDoc.exists) {
          members.add(
            UserData.fromJson(userDoc.data() as Map<String, dynamic>),
          );
        }
      }

      return members;
    } catch (e) {
      print('ProjectService::getProjectMembers $e');
      throw Exception('Failed to get project members: $e');
    }
  }

  // 일정 및 업무 관리
  Future<void> createSchedule(String projectId, ScheduleData schedule) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 프로젝트 멤버 확인 (팀원 전체 가능)
      final project = await getProject(projectId);
      if (project == null || !project.memberIds.contains(user.uid)) {
        throw Exception('Only project members can create schedules.');
      }

      schedule.createdBy = user.uid;

      await _firestore.collection('projects').doc(projectId).update({
        'schedules': FieldValue.arrayUnion([schedule.toJson()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::createSchedule $e');
      throw Exception('Failed to create schedule: $e');
    }
  }

  Future<void> createTask(
    String projectId,
    String scheduleId,
    TaskData task,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      // 프로젝트 멤버 확인 (팀원 전체 가능)
      final project = await getProject(projectId);
      if (project == null || !project.memberIds.contains(user.uid)) {
        throw Exception('Only project members can create tasks.');
      }

      task.scheduleId = scheduleId;
      task.createdAt = DateTime.now();

      // 해당 스케줄 찾아서 태스크 추가
      final updatedSchedules =
          project.schedules.map((schedule) {
            if (schedule.id == scheduleId) {
              schedule.tasks.add(task);
            }
            return schedule;
          }).toList();

      await _firestore.collection('projects').doc(projectId).update({
        'schedules': updatedSchedules.map((s) => s.toJson()).toList(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::createTask $e');
      throw Exception('Failed to create task: $e');
    }
  }

  // 본인 업무만 편집 가능
  Future<void> updateTask(
    String projectId,
    String taskId,
    TaskData task,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not signed in.');
      }

      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      // 본인 업무인지 확인
      TaskData? targetTask;
      for (var schedule in project.schedules) {
        for (var t in schedule.tasks) {
          if (t.id == taskId) {
            targetTask = t;
            break;
          }
        }
        if (targetTask != null) break;
      }

      if (targetTask == null) {
        throw Exception('Task not found.');
      }

      if (targetTask.assignedUserId != user.uid) {
        throw Exception('You can only edit your own tasks.');
      }

      // 태스크 업데이트
      final updatedSchedules =
          project.schedules.map((schedule) {
            schedule.tasks =
                schedule.tasks.map((t) {
                  if (t.id == taskId) {
                    return task;
                  }
                  return t;
                }).toList();
            return schedule;
          }).toList();

      await _firestore.collection('projects').doc(projectId).update({
        'schedules': updatedSchedules.map((s) => s.toJson()).toList(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::updateTask $e');
      throw Exception('Failed to update task: $e');
    }
  }

  // 타이머 기록
  Future<void> recordWorkTime(
    String projectId,
    String userId,
    Duration time,
  ) async {
    try {
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      if (!project.memberIds.contains(userId)) {
        throw Exception('User is not a project member.');
      }

      final currentTime = project.workTimes[userId] ?? Duration.zero;
      final newTime = currentTime + time;

      await _firestore.collection('projects').doc(projectId).update({
        'workTimes.$userId': newTime.inSeconds,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('ProjectService::recordWorkTime $e');
      throw Exception('Failed to record work time: $e');
    }
  }

  // 매칭 알람 (사용자 직무, 성향, 열정온도, 경력 기반)
  Future<void> sendMatchingNotification(
    String userId,
    ProjectData project,
  ) async {
    try {
      // TODO: 실제 알림 발송 로직 구현 (FCM 등)
      print(
        'Sending matching notification to user: $userId for project: ${project.title}',
      );
    } catch (e) {
      print('ProjectService::sendMatchingNotification $e');
      throw Exception('Failed to send matching notification: $e');
    }
  }

  Future<List<ProjectData>> getRecommendedProjects(String userId) async {
    try {
      // TODO: 매칭 알고리즘 구현
      // 현재는 최신 모집중인 프로젝트들을 반환
      return await searchProjects();
    } catch (e) {
      print('ProjectService::getRecommendedProjects $e');
      throw Exception('Failed to get recommended projects: $e');
    }
  }

  Future<List<UserData>> getRecommendedMembers(String projectId) async {
    try {
      // TODO: 매칭 알고리즘 구현
      // 현재는 빈 리스트 반환
      return [];
    } catch (e) {
      print('ProjectService::getRecommendedMembers $e');
      throw Exception('Failed to get recommended members: $e');
    }
  }

  // MVP 평가
  Future<void> voteMVP(
    String projectId,
    String voterId,
    String candidateId,
    String comment,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.uid != voterId) {
        throw Exception('Invalid voter.');
      }

      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      if (project.status != ProjectStatus.completed) {
        throw Exception('Can only vote MVP for completed projects.');
      }

      if (!project.memberIds.contains(voterId) ||
          !project.memberIds.contains(candidateId)) {
        throw Exception('Both voter and candidate must be project members.');
      }

      // evaluation 컬렉션에 투표 저장
      await _firestore.collection('evaluations').doc(projectId).set({
        'mvpVotes': FieldValue.arrayUnion([
          {
            'voterId': voterId,
            'candidateId': candidateId,
            'comment': comment,
            'timestamp': Timestamp.fromDate(DateTime.now()),
          },
        ]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('ProjectService::voteMVP $e');
      throw Exception('Failed to vote MVP: $e');
    }
  }

  // 동점시 작업시간으로 결정
  Future<String> calculateMVP(String projectId) async {
    try {
      final project = await getProject(projectId);
      if (project == null) {
        throw Exception('Project not found.');
      }

      final evaluationDoc =
          await _firestore.collection('evaluations').doc(projectId).get();
      if (!evaluationDoc.exists) {
        throw Exception('No MVP votes found.');
      }

      final data = evaluationDoc.data() as Map<String, dynamic>;
      final votes = data['mvpVotes'] as List<dynamic>? ?? [];

      // 투표 집계
      Map<String, int> voteCount = {};
      for (var vote in votes) {
        String candidateId = vote['candidateId'];
        voteCount[candidateId] = (voteCount[candidateId] ?? 0) + 1;
      }

      if (voteCount.isEmpty) {
        throw Exception('No votes found.');
      }

      // 최대 득표수 찾기
      int maxVotes = voteCount.values.reduce((a, b) => a > b ? a : b);
      List<String> topCandidates =
          voteCount.entries
              .where((entry) => entry.value == maxVotes)
              .map((entry) => entry.key)
              .toList();

      String mvpWinner;
      if (topCandidates.length == 1) {
        mvpWinner = topCandidates.first;
      } else {
        // 동점시 작업시간으로 결정
        String mostActiveCandidate = topCandidates.first;
        Duration maxWorkTime =
            project.workTimes[mostActiveCandidate] ?? Duration.zero;

        for (String candidateId in topCandidates) {
          Duration workTime = project.workTimes[candidateId] ?? Duration.zero;
          if (workTime > maxWorkTime) {
            maxWorkTime = workTime;
            mostActiveCandidate = candidateId;
          }
        }
        mvpWinner = mostActiveCandidate;
      }

      // MVP 결과 저장
      await _firestore.collection('evaluations').doc(projectId).update({
        'mvpWinner': mvpWinner,
        'calculatedAt': Timestamp.fromDate(DateTime.now()),
      });

      // 사용자의 MVP 횟수 증가
      await _firestore.collection('users').doc(mvpWinner).update({
        'detailData.mvpCount': FieldValue.increment(1),
      });

      return mvpWinner;
    } catch (e) {
      print('ProjectService::calculateMVP $e');
      throw Exception('Failed to calculate MVP: $e');
    }
  }

  // 사용자 프로필 보기 (지원자 검토용)
  Future<UserData> viewApplicantProfile(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User not found.');
      }

      return UserData.fromJson(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('ProjectService::viewApplicantProfile $e');
      throw Exception('Failed to view applicant profile: $e');
    }
  }

  // 사용자의 프로젝트 목록 가져오기
  Future<List<ProjectData>> getUserProjects(String userId) async {
    try {
      final projectsQuery =
          await _firestore
              .collection('projects')
              .where('memberIds', arrayContains: userId)
              .orderBy('updatedAt', descending: true)
              .get();

      return projectsQuery.docs
          .map((doc) => ProjectData.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('ProjectService::getUserProjects $e');
      throw Exception('Failed to get user projects: $e');
    }
  }
}

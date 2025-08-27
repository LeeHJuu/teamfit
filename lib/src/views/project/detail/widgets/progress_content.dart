import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/views/project/detail/widgets/motivational_card.dart';
import 'package:teamfit/src/views/project/detail/widgets/task_item.dart';
import 'package:teamfit/src/views/project/detail/widgets/member_progress_item.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ProgressContent extends StatelessWidget {
  const ProgressContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 동기부여 메시지
        MotivationalCard(),
        SizedBox(height: 20),

        // 오늘의 할일
        _buildTodayTasks(),
        SizedBox(height: 20),

        // 멤버 진행 현황
        _buildMemberProgressStatus(),
      ],
    );
  }

  // 오늘의 할일
  Widget _buildTodayTasks() {
    return ShadowBoxContainer(
      // padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.push_pin, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                '오늘의 할일',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          TaskItem(
            time: '09:00',
            description: '사회적 트렌드 조사/분석',
            completed: true,
            onToggleComplete: () {
              // TODO: 완료 상태 토글
            },
          ),
          SizedBox(height: 8),
          TaskItem(
            time: '13:00',
            description: '문화적 트렌드 조사/분석',
            completed: false,
            onPostpone: () {
              // TODO: 미루기 기능
            },
            onToggleComplete: () {
              // TODO: 완료 상태 토글
            },
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO: 기록 기능
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.primary_60,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('기록하고 열정온도 올리기'),
            ),
          ),
        ],
      ),
    );
  }

  // 멤버 진행 현황
  Widget _buildMemberProgressStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('👀', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text(
                '멤버 진행 현황',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        MemberProgressItem(
          role: '리더',
          nickname: '냥냥이',
          progress: 50,
          totalTime: '3:21:23',
          taskCount: 2,
          taskDetails: [],
          onPoke: () {
            // TODO: 찌르기 기능
          },
        ),
        SizedBox(height: 8),
        MemberProgressItem(
          role: '리더',
          nickname: '냥냥이',
          progress: 50,
          totalTime: '3:21:23',
          taskCount: 2,
          taskDetails: ['24:59:59'],
          onPoke: () {
            // TODO: 찌르기 기능
          },
        ),
        SizedBox(height: 8),
        MemberProgressItem(
          role: '리더',
          nickname: '냥냥이',
          progress: 50,
          totalTime: '3:21:23',
          taskCount: 2,
          taskDetails: ['24:59:59', '24:59:59'],
          onPoke: () {
            // TODO: 찌르기 기능
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/views/project/detail/widgets/remaining_schedule_card.dart';
import 'package:teamfit/src/views/project/detail/widgets/schedule_item.dart';
import 'package:teamfit/src/views/project/detail/widgets/progress_status_card.dart';
import 'package:teamfit/src/views/project/detail/widgets/team_timer_records.dart';

class AllViewContent extends StatelessWidget {
  const AllViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 남은 일정 알림 카드
        Padding(
          padding: EdgeInsets.all(16),
          child: RemainingScheduleCard(
            remainingCount: 1,
            onRecordPressed: () {
              // TODO: 기록 기능 구현
            },
          ),
        ),
        SizedBox(height: 20),

        // 오늘의 팀일정
        _buildTodayTeamSchedule(),
        SizedBox(height: 20),

        // 진행 현황
        Padding(
          padding: EdgeInsets.all(16),
          child: ProgressStatusCard(round: 1, remainingDays: 3, progress: 0.5),
        ),
        SizedBox(height: 20),

        // 팀원 타이머 기록
        Padding(
          padding: EdgeInsets.all(16),
          child: TeamTimerRecords(
            teamName: '무적팀',
            records: [
              TimerRecord(name: '서유리', time: '10:00:00'),
              TimerRecord(name: '황동민', time: '8:25:00'),
              TimerRecord(name: '황동민', time: '6:20:10'),
              TimerRecord(name: '황동민', time: '8:25:00'),
              TimerRecord(name: '황동민', time: '8:25:00'),
              TimerRecord(name: '황동민', time: '8:25:00'),
              TimerRecord(name: '황동민', time: '8:25:00'),
            ],
          ),
        ),
      ],
    );
  }

  // 오늘의 팀일정
  Widget _buildTodayTeamSchedule() {
    return Container(
      color: Color(0xFFFFF3F1),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 팀일정',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ScheduleItem(
            time: '09:00 am',
            duration: '09:00~12:00',
            title: '트렌드 리서치',
            description: '4개의 세부 일정이 있습니다',
          ),
          SizedBox(height: 12),
          ScheduleItem(
            time: '13:00 pm',
            duration: '13:00~17:00',
            title: '주간 회의',
            description: '일정 공유 및 진척도 회의\n이슈 공유',
          ),
        ],
      ),
    );
  }
}

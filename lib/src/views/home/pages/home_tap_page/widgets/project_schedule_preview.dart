import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/theme/custom_text.dart';

class ProjectSchedulePreview extends StatelessWidget {
  const ProjectSchedulePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2025년 5월',
                  style: CustomText.Title_S_18.copyWith(
                    color: CustomColor.gray_10,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: CustomColor.gray_40,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: CustomColor.gray_40,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            // 요일 헤더
            Row(
              children:
                  ['일', '월', '화', '수', '목', '금', '토']
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: CustomText.Body_Light_M_14.copyWith(
                                color: CustomColor.gray_60,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),

            SizedBox(height: 12),

            // 캘린더 그리드
            // Expanded(child: _buildCalendarGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // 5월 6일부터 12일까지의 주간 뷰
    final weekDays = [6, 7, 8, 9, 10, 11, 12];
    final selectedDay = 9; // 수요일이 선택됨

    return Column(
      children: [
        // 날짜 행
        Row(
          children:
              weekDays.map((day) {
                final isSelected = day == selectedDay;
                return Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          isSelected
                              ? Border.all(
                                color: CustomColor.primary_60,
                                width: 2,
                              )
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: CustomText.Body_Light_M_14.copyWith(
                          color:
                              isSelected
                                  ? CustomColor.primary_60
                                  : CustomColor.gray_30,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),

        SizedBox(height: 20),

        // 일정 표시 영역
        Expanded(
          child: Stack(
            children: [
              // 1회차 (6일, 초록색)
              Positioned(
                left: _getPositionForDay(6, weekDays),
                top: 0,
                child: _buildScheduleItem('1회차', Colors.green),
              ),
              // 2회차 (10일, 빨간색)
              Positioned(
                left: _getPositionForDay(10, weekDays),
                top: 30,
                child: _buildScheduleItem('2회차', Colors.red),
              ),
              // 3회차 (12일, 회색)
              Positioned(
                left: _getPositionForDay(12, weekDays),
                top: 60,
                child: _buildScheduleItem('3회차', CustomColor.gray_60),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(String title, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: CustomText.Body_Light_XS_12.copyWith(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  double _getPositionForDay(int day, List<int> weekDays) {
    final index = weekDays.indexOf(day);
    if (index == -1) return 0;

    // 각 날짜 칸의 너비를 계산 (전체 너비를 7로 나눔)
    return index * 35.0; // 대략적인 날짜 칸 너비
  }
}

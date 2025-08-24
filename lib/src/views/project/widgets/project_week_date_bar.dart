import 'package:flutter/material.dart';

class ProjectWeeklyDateBar extends StatelessWidget {
  const ProjectWeeklyDateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final now = DateTime.now();
          // 이번주 일요일 구하기
          final sunday = now.subtract(Duration(days: now.weekday % 7));
          final day = sunday.add(Duration(days: index));
          final isToday =
              day.year == now.year &&
              day.month == now.month &&
              day.day == now.day;
          final weekDays = ['일', '월', '화', '수', '목', '금', '토'];
          return Column(
            children: [
              Text(
                weekDays[index],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              isToday
                  ? Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            ],
          );
        }),
      ),
    );
  }
}

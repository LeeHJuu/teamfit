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
}

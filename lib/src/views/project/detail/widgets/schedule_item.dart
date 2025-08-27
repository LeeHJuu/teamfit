import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class ScheduleItem extends StatelessWidget {
  final String time;
  final String duration;
  final String title;
  final String description;
  final int participantCount;

  const ScheduleItem({
    super.key,
    required this.time,
    required this.duration,
    required this.title,
    required this.description,
    this.participantCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColor.primary_60,
            ),
          ),
        ),
        Expanded(
          child: ShadowBoxContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duration,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey, size: 20),
                        Icon(Icons.person, color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '+${participantCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

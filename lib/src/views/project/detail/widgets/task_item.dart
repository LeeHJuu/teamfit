import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class TaskItem extends StatelessWidget {
  final String time;
  final String description;
  final bool completed;
  final VoidCallback? onPostpone;
  final VoidCallback? onToggleComplete;

  const TaskItem({
    super.key,
    required this.time,
    required this.description,
    required this.completed,
    this.onPostpone,
    this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: CustomColor.primary_60, size: 20),
          SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColor.primary_60,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: completed ? TextDecoration.lineThrough : null,
                color: completed ? Colors.grey[600] : Colors.black,
              ),
            ),
          ),
          if (!completed)
            TextButton(
              onPressed: onPostpone,
              child: Text(
                '미루기',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: onToggleComplete,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: completed ? Colors.red : Colors.white,
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  completed
                      ? Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}

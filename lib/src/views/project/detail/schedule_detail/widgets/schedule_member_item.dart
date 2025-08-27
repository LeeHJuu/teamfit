import 'package:flutter/material.dart';
import 'tag_task_manager.dart';

class ScheduleMemberItem extends StatelessWidget {
  final String position;
  final String nickname;
  final VoidCallback? onAddPressed;

  const ScheduleMemberItem({
    super.key,
    this.position = '포지션',
    this.nickname = '닉네임',
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 멤버 정보
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    position,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    nickname,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: onAddPressed ?? () {},
                icon: Icon(Icons.add),
              ),
            ],
          ),

          SizedBox(height: 12),

          // 태그-과제 관리 영역
          TagTaskManager(),
        ],
      ),
    );
  }
}

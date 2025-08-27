import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class MemberProgressItem extends StatefulWidget {
  final String role;
  final String nickname;
  final int progress;
  final String totalTime;
  final int taskCount;
  final List<String> taskDetails;
  final VoidCallback? onPoke;

  const MemberProgressItem({
    super.key,
    required this.role,
    required this.nickname,
    required this.progress,
    required this.totalTime,
    required this.taskCount,
    this.taskDetails = const [],
    this.onPoke,
  });

  @override
  State<MemberProgressItem> createState() => _MemberProgressItemState();
}

class _MemberProgressItemState extends State<MemberProgressItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: 프로필과 찌르기 버튼
          _buildProfileAndPokeRow(),
          SizedBox(height: 12),

          // Row 2: 진행율과 총 시간
          _buildProgressAndTimeRow(),
          SizedBox(height: 12),

          // Row 3: 작업 개수와 확장/축소 버튼
          _buildTaskCountAndExpandRow(),

          // 확장된 작업 상세 정보
          if (expanded) _buildExpandedTaskDetails(),
        ],
      ),
    );
  }

  // Row 1: 프로필과 찌르기 버튼
  Widget _buildProfileAndPokeRow() {
    return Row(
      children: [
        // 프로필 섹션
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600], size: 24),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.role,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  widget.nickname,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),

        Spacer(),

        // 찌르기 버튼
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextButton(
            onPressed: widget.onPoke,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '찌르기',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Row 2: 진행율과 총 시간
  Widget _buildProgressAndTimeRow() {
    return Row(
      children: [
        // 진행율
        Row(
          children: [
            Text(
              '진행율',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFFFF3F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${widget.progress}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 24),

        // 총 시간
        Row(
          children: [
            Text(
              '총 시간',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.totalTime,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Row 3: 작업 개수와 확장/축소 버튼
  Widget _buildTaskCountAndExpandRow() {
    return Row(
      children: [
        Text(
          '총 ${widget.taskCount}개의 작업이 있습니다.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        Spacer(),

        GestureDetector(
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
          child: Icon(
            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
      ],
    );
  }

  // 확장된 작업 상세 정보
  Widget _buildExpandedTaskDetails() {
    return Column(
      children: [
        SizedBox(height: 12),
        Divider(height: 1),
        SizedBox(height: 12),
        ...widget.taskDetails.asMap().entries.map(
          (entry) => _buildTaskDetailItem(entry.key, entry.value),
        ),
      ],
    );
  }

  Widget _buildTaskDetailItem(int index, String detail) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          _buildTaskStatusIcon(index),
          SizedBox(width: 8),
          Text('일정', style: TextStyle(fontSize: 12, color: Colors.black)),
          SizedBox(width: 8),
          Text(detail, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildTaskStatusIcon(int index) {
    final isFirstTask = index == 0;
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: isFirstTask ? Colors.red : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.check,
        color: isFirstTask ? Colors.white : Colors.grey[300],
        size: 12,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TaskInputWidget extends StatefulWidget {
  final Function(String) onTaskAdded;

  const TaskInputWidget({super.key, required this.onTaskAdded});

  @override
  State<TaskInputWidget> createState() => _TaskInputWidgetState();
}

class _TaskInputWidgetState extends State<TaskInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onTaskAdded(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.add, size: 16),
        SizedBox(width: 4),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: '과제를 입력해주세요',
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(fontSize: 12),
            onSubmitted: (_) => _addTask(),
          ),
        ),
      ],
    );
  }
}

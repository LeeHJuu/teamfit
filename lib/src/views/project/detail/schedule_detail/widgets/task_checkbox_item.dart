import 'package:flutter/material.dart';

class TaskCheckboxItem extends StatefulWidget {
  final String taskText;
  final bool isCompleted;
  final Function(bool) onChanged;
  final VoidCallback onDelete;

  const TaskCheckboxItem({
    super.key,
    required this.taskText,
    this.isCompleted = false,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<TaskCheckboxItem> createState() => _TaskCheckboxItemState();
}

class _TaskCheckboxItemState extends State<TaskCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: widget.isCompleted,
              onChanged: (value) {
                widget.onChanged(value ?? false);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.taskText,
              style: TextStyle(
                fontSize: 12,
                color: widget.isCompleted ? Colors.grey[600] : Colors.black,
                decoration:
                    widget.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete_outline, size: 16, color: Colors.grey[600]),
            constraints: BoxConstraints(minWidth: 24, minHeight: 24),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

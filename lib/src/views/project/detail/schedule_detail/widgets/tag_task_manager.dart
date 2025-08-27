import 'package:flutter/material.dart';
import 'tag_selector_widget.dart';
import 'task_input_widget.dart';
import 'task_checkbox_item.dart';

class TaskItem {
  final String id;
  final String text;
  bool isCompleted;

  TaskItem({required this.id, required this.text, this.isCompleted = false});
}

class TagTaskManager extends StatefulWidget {
  const TagTaskManager({super.key});

  @override
  State<TagTaskManager> createState() => _TagTaskManagerState();
}

class _TagTaskManagerState extends State<TagTaskManager> {
  Map<TaskPriority, List<TaskItem>> tasksByTag = {};
  Set<TaskPriority> selectedTags = {};

  void _addTag(TaskPriority priority) {
    setState(() {
      selectedTags.add(priority);
      if (!tasksByTag.containsKey(priority)) {
        tasksByTag[priority] = [];
      }
    });
  }

  void _addTask(TaskPriority priority, String taskText) {
    setState(() {
      final newTask = TaskItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: taskText,
      );
      tasksByTag[priority]?.add(newTask);
    });
  }

  void _toggleTask(TaskPriority priority, String taskId, bool isCompleted) {
    setState(() {
      final tasks = tasksByTag[priority];
      if (tasks != null) {
        final taskIndex = tasks.indexWhere((task) => task.id == taskId);
        if (taskIndex != -1) {
          tasks[taskIndex].isCompleted = isCompleted;
        }
      }
    });
  }

  void _deleteTask(TaskPriority priority, String taskId) {
    setState(() {
      tasksByTag[priority]?.removeWhere((task) => task.id == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 선택된 태그들과 해당 과제들
        ...selectedTags.map((priority) {
          final tasks = tasksByTag[priority] ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _tagAndTasks(priority, tasks),
          );
        }).toList(),

        // SizedBox(height: 8),

        // 새 태그 추가 버튼 (선택된 태그가 없거나 3개 미만일 때만)
        if (selectedTags.length < 3) TagSelectorWidget(onTagSelected: _addTag),
      ],
    );
  }

  Column _tagAndTasks(TaskPriority priority, List<TaskItem> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 태그 표시
        TagSelectorWidget(
          selectedTag: priority,
          onTagSelected: (_) {}, // 이미 선택된 태그는 변경 불가
        ),

        SizedBox(height: 8),

        // 해당 태그의 과제들
        ...tasks.map((task) {
          return TaskCheckboxItem(
            taskText: task.text,
            isCompleted: task.isCompleted,
            onChanged:
                (isCompleted) => _toggleTask(priority, task.id, isCompleted),
            onDelete: () => _deleteTask(priority, task.id),
          );
        }).toList(),

        // 과제 입력
        TaskInputWidget(
          onTaskAdded: (taskText) => _addTask(priority, taskText),
        ),

        SizedBox(height: 12),
      ],
    );
  }
}

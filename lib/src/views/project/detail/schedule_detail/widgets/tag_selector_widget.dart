import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_color.dart';

enum TaskPriority { important, normal, later }

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
      case TaskPriority.important:
        return '중요';
      case TaskPriority.normal:
        return '보통';
      case TaskPriority.later:
        return '나중';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.important:
        return CustomColor.tag_important;
      case TaskPriority.normal:
        return CustomColor.tag_normal;
      case TaskPriority.later:
        return CustomColor.tag_later;
    }
  }
}

class TagSelectorWidget extends StatelessWidget {
  final TaskPriority? selectedTag;
  final Function(TaskPriority) onTagSelected;

  const TagSelectorWidget({
    super.key,
    this.selectedTag,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTagBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selectedTag?.color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
          border:
              selectedTag != null
                  ? null
                  : Border.all(color: CustomColor.gray_80),
        ),
        child: Text(
          selectedTag?.displayName ?? '태그를 선택해주세요',
          style: TextStyle(
            fontSize: 12,
            color: selectedTag != null ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  void _showTagBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => _TagBottomSheet(
            selectedTag: selectedTag,
            onTagSelected: onTagSelected,
          ),
    );
  }
}

class _TagBottomSheet extends StatefulWidget {
  final TaskPriority? selectedTag;
  final Function(TaskPriority) onTagSelected;

  const _TagBottomSheet({
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  State<_TagBottomSheet> createState() => _TagBottomSheetState();
}

class _TagBottomSheetState extends State<_TagBottomSheet> {
  TaskPriority? _tempSelectedTag;

  @override
  void initState() {
    super.initState();
    _tempSelectedTag = widget.selectedTag;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들 바
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: CustomColor.gray_80,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),

          Text(
            '중요도',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // 태그 선택 버튼들
          Row(
            children:
                TaskPriority.values.map((priority) {
                  final isSelected = _tempSelectedTag == priority;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _tempSelectedTag = priority;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? priority.color : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? priority.color
                                      : CustomColor.gray_80,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              priority.displayName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : CustomColor.gray_40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: 20),

          // 확인 버튼
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  _tempSelectedTag != null
                      ? () {
                        widget.onTagSelected(_tempSelectedTag!);
                        Navigator.pop(context);
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _tempSelectedTag != null
                        ? CustomColor.primary_60
                        : CustomColor.gray_80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

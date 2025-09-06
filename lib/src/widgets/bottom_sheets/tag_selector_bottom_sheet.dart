import 'package:flutter/material.dart';
import '../../config/theme/custom_color.dart';
import '../../config/enums.dart';

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
      case TaskPriority.high:
        return '중요';
      case TaskPriority.normal:
        return '보통';
      case TaskPriority.low:
        return '나중';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.high:
        return CustomColor.tag_important;
      case TaskPriority.normal:
        return CustomColor.tag_normal;
      case TaskPriority.low:
        return CustomColor.tag_later;
    }
  }
}

class TagSelectorBottomSheet extends StatefulWidget {
  final TaskPriority? selectedTag;
  final Function(TaskPriority) onTagSelected;

  const TagSelectorBottomSheet({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  State<TagSelectorBottomSheet> createState() => _TagSelectorBottomSheetState();
}

class _TagSelectorBottomSheetState extends State<TagSelectorBottomSheet> {
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

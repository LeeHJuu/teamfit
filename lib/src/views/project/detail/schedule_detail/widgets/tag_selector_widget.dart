import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/enums.dart';
import '../../../../../widgets/bottom_sheets/tag_selector_bottom_sheet.dart';

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
          (context) => TagSelectorBottomSheet(
            selectedTag: selectedTag,
            onTagSelected: onTagSelected,
          ),
    );
  }
}

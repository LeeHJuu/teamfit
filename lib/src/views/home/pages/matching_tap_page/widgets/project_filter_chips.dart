import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/config/enums.dart';

class ProjectFilterChips extends StatefulWidget {
  const ProjectFilterChips({Key? key}) : super(key: key);

  @override
  _ProjectFilterChipsState createState() => _ProjectFilterChipsState();
}

class _ProjectFilterChipsState extends State<ProjectFilterChips> {
  UserGoal? selectedProjectType;
  UserRole? selectedPosition;
  ProjectMemberCareerLevel? selectedExperience;
  MeetingType? selectedMeeting;

  final List<FilterItem<UserGoal>> projectTypeItems = [
    FilterItem('프로젝트 유형', null),
    ...UserGoal.values.map((e) => FilterItem(e.label, e)),
  ];

  final List<FilterItem<UserRole>> positionItems = [
    FilterItem('포지션', null),
    FilterItem('개발', UserRole.development),
    FilterItem('디자인', UserRole.design),
    FilterItem('경영·비즈니스', UserRole.business),
    FilterItem('마케팅·광고', UserRole.marketing),
  ];

  final List<FilterItem<ProjectMemberCareerLevel>> experienceItems = [
    FilterItem('경력', null),
    ...ProjectMemberCareerLevel.values.map((e) => FilterItem(e.label, e)),
  ];

  final List<FilterItem<MeetingType>> meetingItems = [
    FilterItem('진행 방식', null),
    ...MeetingType.values.map((e) => FilterItem(e.label, e)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildFilterChip<UserGoal>(
                items: projectTypeItems,
                selectedValue: selectedProjectType,
                onSelected:
                    (value) => setState(() => selectedProjectType = value),
              );
            case 1:
              return _buildFilterChip<UserRole>(
                items: positionItems,
                selectedValue: selectedPosition,
                onSelected: (value) => setState(() => selectedPosition = value),
              );
            case 2:
              return _buildFilterChip<ProjectMemberCareerLevel>(
                items: experienceItems,
                selectedValue: selectedExperience,
                onSelected:
                    (value) => setState(() => selectedExperience = value),
              );
            case 3:
              return _buildFilterChip<MeetingType>(
                items: meetingItems,
                selectedValue: selectedMeeting,
                onSelected: (value) => setState(() => selectedMeeting = value),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildFilterChip<T>({
    required List<FilterItem<T>> items,
    required T? selectedValue,
    required Function(T?) onSelected,
  }) {
    final selectedItem = items.firstWhere(
      (item) => item.value == selectedValue,
      orElse: () => items.first,
    );
    final isSelected = selectedValue != null;

    return GestureDetector(
      onTap: () => _showFilterMenu(context, items, selectedValue, onSelected),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? CustomColor.primary_60 : Colors.white,
          border: Border.all(
            color: isSelected ? CustomColor.primary_60 : CustomColor.gray_80,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedItem.label,
              style: CustomText.Body_Light_S_13.copyWith(
                color: isSelected ? Colors.white : CustomColor.gray_40,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isSelected ? Colors.white : CustomColor.gray_40,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterMenu<T>(
    BuildContext context,
    List<FilterItem<T>> items,
    T? currentValue,
    Function(T?) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items.first.label, style: CustomText.Label_Heavy_M_16),
                SizedBox(height: 16),
                ...items
                    .skip(1)
                    .map(
                      (item) => _buildMenuItem(
                        item.label,
                        currentValue == item.value,
                        () {
                          onSelected(
                            currentValue == item.value ? null : item.value,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                if (currentValue != null) ...[
                  SizedBox(height: 8),
                  _buildMenuItem('전체', false, () {
                    onSelected(null);
                    Navigator.pop(context);
                  }),
                ],
              ],
            ),
          ),
    );
  }

  Widget _buildMenuItem(String text, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          style: CustomText.Body_Light_M_14.copyWith(
            color: isSelected ? CustomColor.primary_60 : CustomColor.gray_30,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class FilterItem<T> {
  final String label;
  final T? value;

  FilterItem(this.label, this.value);
}

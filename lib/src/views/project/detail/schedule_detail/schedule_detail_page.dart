import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/widgets/components/rounded_container.dart';
import 'package:teamfit/src/models/schedule_data.dart';
import 'widgets/schedule_detail_input_section.dart';
import 'widgets/schedule_member_item.dart';
import '../../../../widgets/bottom_sheets/date_picker_bottom_sheet.dart';

class ScheduleDetailPage extends StatefulWidget {
  final ScheduleData scheduleData;
  final int roundNumber;

  const ScheduleDetailPage({
    super.key,
    required this.scheduleData,
    required this.roundNumber,
  });

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  late TextEditingController scheduleController;
  late TextEditingController tagController;
  late TextEditingController taskController;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    scheduleController = TextEditingController();
    tagController = TextEditingController();
    taskController = TextEditingController();
    selectedStartDate = widget.scheduleData.startDate;
    selectedEndDate = widget.scheduleData.endDate;
  }

  @override
  void dispose() {
    scheduleController.dispose();
    tagController.dispose();
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      scrolledUnderElevation: 0,
        title: Text('달력'),
        backgroundColor: CustomColor.primary_60,
        foregroundColor: Colors.white,
      ),
      backgroundColor: CustomColor.primary_60,
      body: RoundedContainer(
        background: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 상단 회차 및 일정 입력 영역
              ScheduleDetailInputSection(
                roundNumber: widget.roundNumber,
                scheduleData: widget.scheduleData,
                scheduleController: scheduleController,
                onDatePressed: _selectDate,
              ),

              SizedBox(height: 20),

              // 하단 멤버 및 태그/과제 관리 영역
              Expanded(child: _buildMemberAndTaskSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberAndTaskSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 멤버 리스트
          ...List.generate(4, (index) => ScheduleMemberItem()),
        ],
      ),
    );
  }

  void _selectDate() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DatePickerBottomSheet(
            initialStartDate: selectedStartDate,
            initialEndDate: selectedEndDate,
            onDateRangeSelected: (startDate, endDate) {
              setState(() {
                selectedStartDate = startDate;
                selectedEndDate = endDate;
              });
              // 날짜 선택 처리
              print('Selected date range: $startDate - $endDate');
            },
          ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/theme/custom_color.dart';
import '../../config/theme/custom_text.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime startDate, DateTime endDate) onDateRangeSelected;

  const DatePickerBottomSheet({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onDateRangeSelected,
  });

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  late DateTime _currentMonth;
  DateTime? _tempStartDate;
  DateTime? _tempEndDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _tempStartDate = widget.initialStartDate;
    _tempEndDate = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 핸들 바
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: CustomColor.gray_80,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 헤더
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('날짜 선택', style: CustomText.Title_M_20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: CustomColor.gray_40,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // 월 네비게이션
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _previousMonth,
                  child: Icon(
                    Icons.chevron_left,
                    color: CustomColor.gray_40,
                    size: 24,
                  ),
                ),
                Text(
                  '${_currentMonth.year}.${_currentMonth.month.toString().padLeft(2, '0')}',
                  style: CustomText.Label_Heavy_M_16,
                ),
                GestureDetector(
                  onTap: _nextMonth,
                  child: Icon(
                    Icons.chevron_right,
                    color: CustomColor.gray_40,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 달력
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildCalendar(),
            ),
          ),

          // 확인 버튼
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    (_tempStartDate != null && _tempEndDate != null)
                        ? () {
                          widget.onDateRangeSelected(
                            _tempStartDate!,
                            _tempEndDate!,
                          );
                          Navigator.pop(context);
                        }
                        : null,
                style: FilledButton.styleFrom(
                  backgroundColor:
                      (_tempStartDate != null && _tempEndDate != null)
                          ? CustomColor.primary_60
                          : CustomColor.gray_80,
                ),
                child: Text(
                  '확인',
                  style: CustomText.Label_Heavy_M_16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );
    final daysInMonth = lastDayOfMonth.day;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final day = index + 1;
        final date = DateTime(_currentMonth.year, _currentMonth.month, day);
        final isToday = _isSameDay(date, DateTime.now());

        return _buildDateCell(date, isToday);
      },
    );
  }

  Widget _buildDateCell(DateTime date, bool isToday) {
    final isStartDate = _isSameDay(date, _tempStartDate);
    final isEndDate = _isSameDay(date, _tempEndDate);
    final isSelected = isStartDate || isEndDate;
    final isInRange = _isDateInRange(date);

    Color? backgroundColor;
    BorderRadius? borderRadius;

    // 선택된 날짜나 범위 내 날짜는 모두 동일한 불투명 색상
    if (isSelected || isInRange) {
      backgroundColor = CustomColor.primary_90;

      // 보더 레디우스 설정
      if (isStartDate && isEndDate) {
        // 시작일과 종료일이 같은 경우 (하루만 선택)
        borderRadius = BorderRadius.circular(30);
      } else if (isStartDate && _tempEndDate == null) {
        // 시작일만 선택된 경우: 모든 방향에 둥글게
        borderRadius = BorderRadius.circular(30);
      } else if (isStartDate) {
        // 시작일: 왼쪽만 둥글게
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      } else if (isEndDate) {
        // 종료일: 오른쪽만 둥글게
        borderRadius = BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        );
      } else {
        // 범위 내 날짜: 직각
        borderRadius = BorderRadius.zero;
      }
    }

    return GestureDetector(
      onTap: () => _onDateTap(date),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: CustomText.Body_Light_M_14.copyWith(
              color: CustomColor.gray_10,
            ),
          ),
        ),
      ),
    );
  }

  void _onDateTap(DateTime date) {
    setState(() {
      if (_tempStartDate == null ||
          (_tempStartDate != null && _tempEndDate != null)) {
        // 새로운 선택 시작
        _tempStartDate = date;
        _tempEndDate = null;
      } else if (_tempStartDate != null && _tempEndDate == null) {
        // 종료 날짜 선택
        if (date.isBefore(_tempStartDate!)) {
          // 시작 날짜보다 이전 날짜를 선택한 경우, 무시
          return;
        } else {
          _tempEndDate = date;
        }
      }
    });
  }

  bool _isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isDateInRange(DateTime date) {
    if (_tempStartDate == null || _tempEndDate == null) return false;
    return date.isAfter(_tempStartDate!) && date.isBefore(_tempEndDate!);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }
}

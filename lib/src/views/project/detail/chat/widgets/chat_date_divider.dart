import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:intl/intl.dart';

class ChatDateDivider extends StatelessWidget {
  final DateTime date;

  const ChatDateDivider({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          _formatDate(date),
          style: CustomText.Body_Light_S_13.copyWith(
            color: CustomColor.gray_50,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    final formatter = DateFormat('yyyy년 M월 d일');
    final weekday = weekdays[date.weekday % 7];
    return '${formatter.format(date)}($weekday)';
  }
}

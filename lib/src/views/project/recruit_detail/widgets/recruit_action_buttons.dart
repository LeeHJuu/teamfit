import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';

class RecruitActionButtons extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;
  final VoidCallback onApply;
  final VoidCallback onReject;

  const RecruitActionButtons({
    Key? key,
    required this.recruitInfo,
    required this.onApply,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildRejectButton()),
          SizedBox(width: 12),
          Expanded(flex: 2, child: _buildApplyButton()),
        ],
      ),
    );
  }

  Widget _buildRejectButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.primary_60),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onReject,
          child: Center(
            child: Text(
              '거절하기',
              style: CustomText.Label_Heavy_M_16.copyWith(
                color: CustomColor.primary_60,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: CustomColor.primary_60,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onApply,
          child: Center(
            child: Text(
              '지원하기',
              style: CustomText.Label_Heavy_M_16.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

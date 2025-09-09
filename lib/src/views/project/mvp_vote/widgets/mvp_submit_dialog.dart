import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class MvpSubmitDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const MvpSubmitDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          SizedBox(height: 12),
          _buildSubtitle(),
          SizedBox(height: 32),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '투표 결과를 제출할까요?',
      style: CustomText.Title_S_18,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      '제출 후에는 수정할 수 없어요.',
      style: CustomText.Body_Light_M_14.copyWith(color: CustomColor.gray_50),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(child: _buildCancelButton()),
        SizedBox(width: 12),
        Expanded(child: _buildConfirmButton()),
      ],
    );
  }

  Widget _buildCancelButton() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.primary_60),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onCancel,
          child: Center(
            child: Text(
              '다시 확인하기',
              style: CustomText.Label_Heavy_M_16.copyWith(
                color: CustomColor.primary_60,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: CustomColor.primary_60,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onConfirm,
          child: Center(
            child: Text(
              '제출하기',
              style: CustomText.Label_Heavy_M_16.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

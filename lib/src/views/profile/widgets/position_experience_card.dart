import 'package:flutter/material.dart';
import '../../../models/user_data.dart';
import '../../../config/enums.dart';
import '../../../config/theme/custom_color.dart';
import '../../../config/theme/custom_text.dart';

class PositionExperienceCard extends StatelessWidget {
  final UserData member;

  const PositionExperienceCard({Key? key, required this.member})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            '포지션/경력',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.gray_10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTag(_getRoleText()),
            const SizedBox(width: 8),
            _buildTag(_getCareerText()),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: CustomText.Body_Light_M_14.copyWith(color: CustomColor.gray_30),
      ),
    );
  }

  String _getRoleText() {
    final role = member.role;
    if (role == null) return '미입력';

    switch (role) {
      case UserRole.development:
        return '개발';
      case UserRole.design:
        return '디자인';
      case UserRole.marketing:
        return '마케팅';
      case UserRole.business:
        return '비즈니스';
      default:
        return role.label;
    }
  }

  String _getCareerText() {
    final career = member.career;
    if (career == null) return '미입력';

    switch (career) {
      case UserCareerLevel.student:
        return '학생';
      case UserCareerLevel.lessThanOne:
        return '1년 차 미만';
      case UserCareerLevel.oneToThree:
        return '1년 차 이상 ~ 3년 차 이하';
      case UserCareerLevel.fourToSix:
        return '4년 차 이상 ~ 6년 차 이하';
      case UserCareerLevel.sevenPlus:
        return '7년 차 이상';
    }
  }
}

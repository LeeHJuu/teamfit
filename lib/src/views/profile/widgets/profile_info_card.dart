import 'package:flutter/material.dart';
import '../../../models/user_data.dart';
import '../../../config/theme/custom_color.dart';
import '../../../config/theme/custom_text.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserData member;

  const ProfileInfoCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            '프로필',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.gray_10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTag(_getGenderText()),
            const SizedBox(width: 8),
            _buildTag(_getAgeText()),
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

  String _getGenderText() {
    final gender = member.detailData?.gender;
    if (gender == null) return '미입력';

    switch (gender) {
      case 0:
        return '남성';
      case 1:
        return '여성';
      default:
        return '기타';
    }
  }

  String _getAgeText() {
    final birthDate = member.detailData?.birthDate;
    if (birthDate == null) return '미입력';

    final now = DateTime.now();
    final age = now.year - birthDate.year;

    if (age < 20) return '10대';
    if (age < 30) return '20대';
    if (age < 40) return '30대';
    if (age < 50) return '40대';
    return '50대 이상';
  }
}

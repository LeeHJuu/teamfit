import 'package:flutter/material.dart';
import '../../../models/user_data.dart';
import '../../../config/theme/custom_color.dart';
import '../../../config/theme/custom_text.dart';

class SkillsCard extends StatelessWidget {
  final UserData member;

  const SkillsCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills = _getSkills();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            '기술',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.gray_10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => _buildTag(skill)).toList(),
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

  List<String> _getSkills() {
    final stackTags = member.detailData?.stackTags;
    if (stackTags != null && stackTags.isNotEmpty) {
      return stackTags;
    }

    // 기본 기술 스택 (실제로는 사용자 데이터에서 가져와야 함)
    return ['UX 디자인', 'UI 디자인', 'Figma', 'Photoshop'];
  }
}

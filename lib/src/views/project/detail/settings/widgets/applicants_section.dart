import 'package:flutter/material.dart';
import '../../../../../models/user_data.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/theme/custom_text.dart';

class ApplicantsSection extends StatelessWidget {
  final List<UserData> applicants;
  final Function(UserData) onProfileTap;

  const ApplicantsSection({
    Key? key,
    required this.applicants,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 지원자 타이틀
        Text(
          '지원자',
          style: CustomText.Title_L_22.copyWith(color: CustomColor.gray_10),
        ),
        const SizedBox(height: 16),
        // 지원자 목록
        ...applicants.map((applicant) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ApplicantItem(
              applicant: applicant,
              onProfileTap: () => onProfileTap(applicant),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class ApplicantItem extends StatelessWidget {
  final UserData applicant;
  final VoidCallback onProfileTap;

  const ApplicantItem({
    Key? key,
    required this.applicant,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final role = applicant.detailData?.role?.label ?? '역할 미정';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // 프로필 이미지
          CircleAvatar(
            radius: 24,
            backgroundColor: CustomColor.gray_90,
            child: Icon(Icons.person, color: CustomColor.gray_60, size: 24),
          ),
          const SizedBox(width: 12),
          // 지원자 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: CustomText.Body_Light_M_14.copyWith(
                    color: CustomColor.gray_60,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  applicant.nickname,
                  style: CustomText.Label_Light_M_16.copyWith(
                    color: CustomColor.gray_10,
                  ),
                ),
              ],
            ),
          ),
          // 프로필 보기 버튼
          OutlinedButton(
            onPressed: onProfileTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: CustomColor.gray_80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              '프로필 보기',
              style: CustomText.Body_Light_S_13.copyWith(
                color: CustomColor.gray_30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

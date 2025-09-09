import 'package:flutter/material.dart';
import '../../../models/user_data.dart';
import '../../../config/theme/custom_color.dart';
import '../../../config/theme/custom_text.dart';

class ProfileHeader extends StatelessWidget {
  final UserData member;

  const ProfileHeader({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 프로필 이미지
          CircleAvatar(
            radius: 40,
            backgroundColor: CustomColor.gray_90,
            child: Icon(Icons.person, color: CustomColor.gray_60, size: 40),
          ),
          const SizedBox(height: 16),
          // 이름
          Text(
            member.nickname,
            style: CustomText.Title_M_20.copyWith(color: CustomColor.gray_10),
          ),
          const SizedBox(height: 8),
          // 매너 온도 배지
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: CustomColor.primary_60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '매너온도 ${member.mannerTemperature?.toInt() ?? 0}°C',
              style: CustomText.Body_Heavy_S_13.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

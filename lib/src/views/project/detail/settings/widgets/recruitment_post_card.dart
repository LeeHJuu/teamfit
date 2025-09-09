import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_color.dart';
import '../../../../../config/theme/custom_text.dart';

class RecruitmentPostCard extends StatelessWidget {
  final VoidCallback onEndRecruitment;

  const RecruitmentPostCard({Key? key, required this.onEndRecruitment})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 팀원 모집글 타이틀
        Text(
          '팀원 모집글',
          style: CustomText.Title_L_22.copyWith(color: CustomColor.gray_10),
        ),
        const SizedBox(height: 16),
        // 프로젝트 정보 카드
        Row(
          children: [
            SizedBox(width: 12),
            // 프로젝트 이미지
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: CustomColor.gray_90,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Team fit',
                  style: CustomText.Body_Heavy_M_14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 프로젝트 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '프로젝트 유형',
                    style: CustomText.Body_Light_S_13.copyWith(
                      color: CustomColor.gray_60,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '프로젝트 이름/최대 20자/최대 2줄',
                    style: CustomText.Label_Heavy_M_16.copyWith(
                      color: CustomColor.gray_10,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 프로젝트 세부 정보
                  _buildProjectInfo(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 모집 종료하기 버튼
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onEndRecruitment,
            child: Text('모집 종료하기', style: CustomText.Body_Heavy_M_14),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectInfo() {
    return Row(
      children: [
        _buildInfoItem(Icons.location_on, '회의 방식'),
        const SizedBox(width: 16),
        _buildInfoItem(Icons.person, 'n명'),
        const SizedBox(width: 16),
        _buildInfoItem(Icons.calendar_today, '~yyyy.mm.dd'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: CustomColor.gray_60),
        const SizedBox(width: 4),
        Text(
          text,
          style: CustomText.Body_Light_S_13.copyWith(
            color: CustomColor.gray_60,
          ),
        ),
      ],
    );
  }
}

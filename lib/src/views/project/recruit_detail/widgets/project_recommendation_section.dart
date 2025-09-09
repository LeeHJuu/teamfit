import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class ProjectRecommendationSection extends StatelessWidget {
  const ProjectRecommendationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomColor.primary_95, CustomColor.primary_90],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(height: 12),
          _buildRecommendationList(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '이런 분을 원해요!',
      style: CustomText.Label_Heavy_M_16.copyWith(
        color: CustomColor.primary_30,
      ),
    );
  }

  Widget _buildRecommendationList() {
    return Column(
      children: [
        _buildRecommendationItem('온도 50도 이상인 분 원해요', '34자 이상 원해요'),
        _buildRecommendationItem('신입 환영해요', ''),
      ],
    );
  }

  Widget _buildRecommendationItem(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: CustomColor.primary_60,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomText.Body_Light_S_13.copyWith(
                    color: CustomColor.primary_30,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: CustomText.Body_Light_XS_12.copyWith(
                      color: CustomColor.primary_40,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

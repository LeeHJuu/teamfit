import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class ProjectRecommendationSection extends StatelessWidget {
  const ProjectRecommendationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: CustomColor.primary_95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이런 분을 원해요!',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.primary_30,
            ),
          ),
          SizedBox(height: 16),
          _buildRecommendationTags(),
          SizedBox(height: 16),
          _buildRecommendationTextBox(),
        ],
      ),
    );
  }

  Widget _buildRecommendationTags() {
    final tags = ['온도 50도 이상인 분 원해요', '3년차 이상 원해요', '신입 환영해요'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          tags.map((tag) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: CustomColor.primary_80,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                tag,
                style: CustomText.Body_Light_S_13.copyWith(
                  color: CustomColor.primary_30,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildRecommendationTextBox() {
    final items = [
      '💡 실험적이고 창의적인 환경을 즐기는 분',
      '💜 의미 있는 일에 진심으로 임할 수 있는 분',
      '🍀 경험과 포트폴리오를 쌓고 싶은 분',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: items.last == item ? 0 : 8),
                child: Text(
                  item,
                  style: CustomText.Body_Light_M_14.copyWith(
                    color: CustomColor.gray_30,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/project_recruit_detail_page.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class RecommendedTeamProjects extends StatefulWidget {
  const RecommendedTeamProjects({super.key});

  @override
  State<RecommendedTeamProjects> createState() =>
      _RecommendedTeamProjectsState();
}

class _RecommendedTeamProjectsState extends State<RecommendedTeamProjects> {
  int _current = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('냥냥님을 위한 추천 팀프로젝트', style: CustomText.Title_S_18),
        ),
        SizedBox(height: 16),
        _buildRecommendedCarousel(),
        SizedBox(height: 16),
        _buildCarouselIndicator(),
      ],
    );
  }

  Widget _buildRecommendedCarousel() {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      items: List.generate(3, (index) {
        return RecommendedTeamProjectItem(
          recruitInfo: _getSampleRecruitInfo(index),
        );
      }),
    );
  }

  Widget _buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(index),
          child: Container(
            width: _current == index ? 24.0 : 12.0,
            height: 12.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  _current == index
                      ? CustomColor.primary_60
                      : CustomColor.gray_90,
            ),
          ),
        );
      }),
    );
  }

  ProjectRecruitInfo _getSampleRecruitInfo(int index) {
    final sampleData = [
      {
        'title': '병원관련 프로젝트 진행하려합니다!',
        'goal': '포트폴리오 제작',
        'meeting': '오프라인',
        'count': 6,
        'duration': '~2025.07.20',
        'techs': ['백엔드', '디자이너', 'Next.js', 'Figma'],
      },
      {
        'title': '공모전 프로젝트 이름/최대 20자/최대 2줄',
        'goal': '공모전',
        'meeting': '온라인',
        'count': 5,
        'duration': '~2025.09.12',
        'techs': ['React', 'Node.js', 'MongoDB'],
      },
      {
        'title': '해커톤 프로젝트 이름/최대 20자/최대 2줄',
        'goal': '해커톤',
        'meeting': '온라인',
        'count': 5,
        'duration': '~2025.09.12',
        'techs': ['Flutter', 'Firebase', 'AI'],
      },
    ];

    final data = sampleData[index];
    return ProjectRecruitInfo(
      id: 'sample_$index',
      projectId: 'project_$index',
      title: data['title'] as String,
      introduction: '샘플 프로젝트 설명입니다.',
      teamName: '팀 이름',
      recruitMembers: [],
      authorId: 'author_$index',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class RecommendedTeamProjectItem extends StatelessWidget {
  final ProjectRecruitInfo recruitInfo;

  const RecommendedTeamProjectItem({super.key, required this.recruitInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: ShadowBoxContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectImage(),
            SizedBox(height: 12),
            _buildProjectInfo(),
            SizedBox(height: 8),
            _buildProjectDetails(),
            SizedBox(height: 12),
            _buildTechTags(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            CustomColor.primary_60.withOpacity(0.8),
            CustomColor.primary_40.withOpacity(0.6),
          ],
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Team\nfit',
            style: CustomText.Label_Heavy_M_16.copyWith(
              color: CustomColor.primary_60,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

          child: Text('🏆 포트폴리오 제작', style: CustomText.Body_Light_XS_12),
        ),
        SizedBox(height: 8),
        Text(
          recruitInfo.title,
          style: CustomText.Label_Heavy_M_16,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildProjectDetails() {
    return Row(
      children: [
        _buildDetailChip(Icons.location_on, '오프라인'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.people, '6명'),
        SizedBox(width: 8),
        _buildDetailChip(Icons.schedule, '~2025.07.20'),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: CustomColor.gray_50),
        SizedBox(width: 2),
        Text(
          text,
          style: CustomText.Body_Light_XXS_11.copyWith(
            color: CustomColor.gray_50,
          ),
        ),
      ],
    );
  }

  Widget _buildTechTags() {
    final techs = ['백엔드', '디자이너', 'Next.js', 'Figma'];

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: techs.take(4).map((tech) => _buildTechTag(tech)).toList(),
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tech,
        style: CustomText.Body_Light_XXS_11.copyWith(
          color: CustomColor.gray_40,
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProjectRecruitDetailPage(recruitInfo: recruitInfo),
      ),
    );
  }
}

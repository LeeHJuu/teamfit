import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/recommended_projects_view_model.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/recommended_team_project_item.dart';
import 'package:teamfit/src/widgets/components/custom_carousel_indicator.dart';

class RecommendedTeamProjects extends ConsumerStatefulWidget {
  const RecommendedTeamProjects({super.key});

  @override
  ConsumerState<RecommendedTeamProjects> createState() =>
      _RecommendedTeamProjectsState();
}

class _RecommendedTeamProjectsState
    extends ConsumerState<RecommendedTeamProjects> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // 위젯이 생성될 때 추천 프로젝트 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recommendedProjectsViewModel.notifier).loadRecommendedProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recommendedProjectsViewModel);

    if (state.isLoading) {
      return Container(
        height: 350,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Container(
        height: 350,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('오류가 발생했습니다'),
              SizedBox(height: 8),
              FilledButton(
                onPressed:
                    () =>
                        ref
                            .read(recommendedProjectsViewModel.notifier)
                            .loadRecommendedProjects(),
                child: Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${state.userName}님을 위한 추천 팀프로젝트',
            style: CustomText.Title_S_18,
          ),
        ),
        SizedBox(height: 16),
        _buildRecommendedCarousel(state),
        SizedBox(height: 16),
        _buildCarouselIndicator(state),
      ],
    );
  }

  Widget _buildRecommendedCarousel(RecommendedProjectsState state) {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          ref
              .read(recommendedProjectsViewModel.notifier)
              .setCurrentIndex(index);
        },
      ),
      items:
          state.projects.map((recruitInfo) {
            return RecommendedTeamProjectItem(recruitInfo: recruitInfo);
          }).toList(),
    );
  }

  Widget _buildCarouselIndicator(RecommendedProjectsState state) {
    return CustomCarouselIndicator(
      itemCount: state.projects.length,
      currentIndex: state.currentIndex,
      onTap: (index) => _carouselController.animateToPage(index),
    );
  }
}

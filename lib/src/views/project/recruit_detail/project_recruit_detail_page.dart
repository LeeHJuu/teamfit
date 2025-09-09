import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_header_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/recruit_info_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_description_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_details_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_recommendation_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/recruit_action_buttons.dart';

class ProjectRecruitDetailPage extends StatefulWidget {
  final ProjectRecruitInfo recruitInfo;

  const ProjectRecruitDetailPage({Key? key, required this.recruitInfo})
    : super(key: key);

  @override
  _ProjectRecruitDetailPageState createState() =>
      _ProjectRecruitDetailPageState();
}

class _ProjectRecruitDetailPageState extends State<ProjectRecruitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ProjectHeaderSection(recruitInfo: widget.recruitInfo),
                SizedBox(height: 16),
                RecruitInfoSection(recruitInfo: widget.recruitInfo),
                SizedBox(height: 24),
                ProjectDescriptionSection(recruitInfo: widget.recruitInfo),
                SizedBox(height: 24),
                ProjectDetailsSection(recruitInfo: widget.recruitInfo),
                SizedBox(height: 24),
                ProjectRecommendationSection(),
                SizedBox(height: 100), // 하단 버튼 여백
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: RecruitActionButtons(
        recruitInfo: widget.recruitInfo,
        onApply: () => _handleApply(),
        onReject: () => _handleReject(),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: false,
      floating: true,
      snap: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
              widget.recruitInfo.projectImage != null
                  ? null
                  : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6B73FF),
                      Color(0xFF9B59B6),
                      Color(0xFFE74C3C),
                    ],
                  ),
          image:
              widget.recruitInfo.projectImage != null
                  ? DecorationImage(
                    image: NetworkImage(widget.recruitInfo.projectImage!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  )
                  : null,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        '무직팀 공고',
        style: CustomText.Title_S_18.copyWith(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            // TODO: 알림 기능 구현
          },
        ),
      ],
    );
  }

  void _handleApply() {
    // TODO: 지원하기 로직 구현
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('지원 완료'),
            content: Text('프로젝트에 지원했습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
    );
  }

  void _handleReject() {
    // TODO: 거절하기 로직 구현
    Navigator.pop(context);
  }
}

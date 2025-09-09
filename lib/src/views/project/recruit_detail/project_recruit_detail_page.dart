import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/models/project_recruit_info.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_header_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/recruit_info_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_description_section.dart';
import 'package:teamfit/src/views/project/recruit_detail/widgets/project_recommendation_section.dart';
import 'package:teamfit/src/widgets/components/rounded_container.dart';

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
      body: Stack(
        children: [
          // 전체 배경 이미지
          _buildBackgroundImage(),
          // 스크롤 가능한 컨텐츠
          _buildScrollableContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
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
        color:
            widget.recruitInfo.projectImage == null ? Colors.grey[300] : null,
      ),
    );
  }

  Widget _buildScrollableContent() {
    return CustomScrollView(
      slivers: [
        // AppBar 영역
        SliverAppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: false,
          floating: true,
          snap: false,
          expandedHeight: 200,
          leading: Container(
            margin: EdgeInsets.only(left: 4),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            '무직팀 공고',
            style: CustomText.Title_S_18.copyWith(color: Colors.white),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 4),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  // TODO: 알림 기능 구현
                },
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.only(
                top: 100,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ProjectHeaderSection(recruitInfo: widget.recruitInfo),
                ],
              ),
            ),
          ),
        ),
        // RoundedContainer 영역
        SliverToBoxAdapter(child: _buildContentSection()),
      ],
    );
  }

  Widget _buildContentSection() {
    return RoundedContainer(
      background: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 24),
          RecruitInfoSection(recruitInfo: widget.recruitInfo),
          SizedBox(height: 32),
          ProjectDescriptionSection(recruitInfo: widget.recruitInfo),
          SizedBox(height: 32),
          ProjectRecommendationSection(),
          SizedBox(height: 32),
          // 지원/거절 버튼
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _buildRejectButton()),
                SizedBox(width: 12),
                Expanded(child: _buildApplyButton()),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRejectButton() {
    return OutlinedButton(
      onPressed: () {},
      child: Text('거절하기', style: CustomText.Body_Light_M_14),
    );
  }

  Widget _buildApplyButton() {
    return FilledButton(
      onPressed: () {},
      child: Text('지원하기', style: CustomText.Body_Light_M_14),
    );
  }

  // ... existing code ...
}

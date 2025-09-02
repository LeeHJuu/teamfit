import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/views/project/detail/widgets/project_app_bar.dart';
import 'package:teamfit/src/views/project/detail/widgets/project_bottom_navigation_bar.dart';
import 'package:teamfit/src/views/project/detail/widgets/project_week_date_bar.dart';
import 'package:teamfit/src/views/project/detail/widgets/all_view_content.dart';
import 'package:teamfit/src/views/project/detail/widgets/progress_content.dart';
import 'package:teamfit/src/widgets/rounded_container.dart';

class ProjectPage extends ConsumerStatefulWidget {
  const ProjectPage({super.key});

  @override
  ConsumerState<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<ProjectPage> {
  int selectedTabIndex = 0; // 0: 전체 보기, 1: 진행 현황

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectAppBar(),
      backgroundColor: CustomColor.primary_60,
      body: Column(
        children: [
          ProjectWeeklyDateBar(),
          Expanded(
            child: RoundedContainer(
              background: Colors.white,
              child: Column(
                children: [
                  _tapButton(),
                  SizedBox(height: 10),
                  Expanded(child: _buildTabContent()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProjectBottomNavigationBar(),
    );
  }

  Container _tapButton() {
    final selectedStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
    final unSelectedStyle = TextStyle(
      color: Colors.grey[700],
      fontWeight: FontWeight.normal,
    );

    Widget tabButton({
      required String title,
      required bool selected,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: selected ? Colors.white : Colors.grey[300],
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Text(title, style: selected ? selectedStyle : unSelectedStyle),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: tabButton(
              title: '전체 보기',
              selected: selectedTabIndex == 0,
              onTap: () {
                setState(() {
                  selectedTabIndex = 0;
                });
              },
            ),
          ),
          Expanded(
            child: tabButton(
              title: '진행 현황',
              selected: selectedTabIndex == 1,
              onTap: () {
                setState(() {
                  selectedTabIndex = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return AllViewContent();
      case 1:
        return ProgressContent();
      default:
        return Container();
    }
  }
}

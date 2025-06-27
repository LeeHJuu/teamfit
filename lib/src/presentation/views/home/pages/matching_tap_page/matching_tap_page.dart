import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/ai_recommended_team_projects.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/all_team_projects.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/make_team_button.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/team_search_tap.dart';

class MatchingTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey,
      ),
      child: ListView(
        children: [
          TeatSearchTap(),
          MakeTeamButton(),
          AIRecommendedTeamProjects(),
          AllTeamProjects(),
        ],
      ),
    );
  }
}

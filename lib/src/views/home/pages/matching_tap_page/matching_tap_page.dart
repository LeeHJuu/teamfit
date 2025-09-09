import 'package:flutter/material.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/recommended_team_projects.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/all_team_projects.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/make_team_button.dart';
import 'package:teamfit/src/views/home/pages/matching_tap_page/widgets/team_search_tap.dart';
import 'package:teamfit/src/widgets/rounded_container.dart';

class MatchingTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: Colors.white,
      child: ListView(
        children: [
          SizedBox(height: 10),
          TeamSearchTap(),
          Padding(padding: const EdgeInsets.all(20), child: MakeTeamButton()),
          RecommendedTeamProjects(),
          AllTeamProjects(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/ai_recommended_team_projects.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/all_team_projects.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/make_team_button.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/widgets/team_search_tap.dart';
import 'package:teamfit/src/presentation/widgets/rounded_container.dart';

class MatchingTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: ListView(
          children: [
            TeamSearchTap(),
            MakeTeamButton(),
            AIRecommendedTeamProjects(),
            AllTeamProjects(),
          ],
        ),
      ),
    );
  }
}

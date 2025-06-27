import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/home_view_model.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/home_tap_page.dart';
import 'package:teamfit/src/presentation/views/home/pages/matching_tap_page/matching_tap_page.dart';
import 'package:teamfit/src/presentation/views/home/pages/my_tap_page/my_tap_page.dart';
import 'package:teamfit/src/presentation/views/home/widgets/home_app_bar.dart';
import 'package:teamfit/src/presentation/views/home/widgets/home_bottom_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModel);
    return Scaffold(
      appBar: HomeAppBar(),
      body: IndexedStack(
        index: state,
        children: [HomeTapPage(), MatchingTapPage(), MyTapPage()],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}

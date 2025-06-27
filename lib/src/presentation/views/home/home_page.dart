import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/widgets/home_app_bar.dart';
import 'package:teamfit/src/presentation/views/home/widgets/home_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(child: Text('data')),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}

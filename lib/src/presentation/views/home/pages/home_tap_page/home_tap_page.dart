import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/project/project_page.dart';

class HomeTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProjectPage()),
        );
      },
      child: Center(child: Text('home tap page')),
    );
  }
}

import 'package:flutter/material.dart';

class ProjectSchedulePreview extends StatelessWidget {
  const ProjectSchedulePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        // height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black26,
        ),
      ),
    );
  }
}

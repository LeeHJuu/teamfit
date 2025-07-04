import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Color background;
  final Widget body;

  RoundedContainer({required this.background, required this.body});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(color: background),
        child: body,
      ),
    );
  }
}

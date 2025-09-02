import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Color background;
  final Widget child;

  RoundedContainer({required this.background, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: background),
        child: child,
      ),
    );
  }
}

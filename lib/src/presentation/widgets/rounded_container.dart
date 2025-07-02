import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  Color background;
  Widget body;
  RoundedContainer({required this.background, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: background,
      ),
      child: body,
    );
  }
}

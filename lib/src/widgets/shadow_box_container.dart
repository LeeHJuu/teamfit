import 'package:flutter/material.dart';

class ShadowBoxContainer extends StatelessWidget {
  Widget child;
  ShadowBoxContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}

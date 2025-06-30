import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  Widget body;
  RoundedContainer(this.body);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey,
      ),
      child: body,
    );
  }
}

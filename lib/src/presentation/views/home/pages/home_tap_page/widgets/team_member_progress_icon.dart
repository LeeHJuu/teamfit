import 'package:flutter/material.dart';

class TeamMemberProgressIcon extends StatelessWidget {
  const TeamMemberProgressIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green,
          ),
        ),
        Text('data'),
        Text('data'),
      ],
    );
  }
}

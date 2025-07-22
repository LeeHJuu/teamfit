import 'package:flutter/material.dart';

class PersonalityResultPage extends StatelessWidget {
  String resultType;
  PersonalityResultPage(this.resultType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text(resultType)));
  }
}

import 'package:flutter/material.dart';

class SkillsShowcase extends StatelessWidget {
  final String skills;

  SkillsShowcase({this.skills});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: new Text(
          skills,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

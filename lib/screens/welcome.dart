import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//welcome screen for new users

class WelcomeScreen extends StatelessWidget {
  //list of pages to give the user info before start using the app
  final listPageViewModel = [
    PageViewModel(
      title: "Welcome to FCAI-HU App",
      bodyWidget: Text('No Need To Go to university'),
      image: Image.asset(
        'assets/welcome/1.png',
        scale: 4,
      ),
    ),
    PageViewModel(
      title: "You can Get all Courses At home",
      bodyWidget: Text('No Need To Go to university'),
      image: Image.asset(
        'assets/welcome/2.png',
        scale: 4,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPageViewModel,
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //set first time to false
        prefs.setBool('firstTime', false);
        //navigate to main screen TODO
        Navigator.pushReplacementNamed(context, AvailableCourses.id);
      },
      onSkip: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //set first time to false
        prefs.setBool('firstTime', false);
        //navigate to main screen TODO
        Navigator.pushReplacementNamed(context, AvailableCourses.id);
      },
      //add skip button
      showSkipButton: true,
      skip: Text('skip'),
      next: Icon(Icons.navigate_next),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      //navigation dots decoration
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: ColorsScheme.purple,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}

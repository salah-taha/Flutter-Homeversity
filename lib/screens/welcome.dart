import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/services/page_handler.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//welcome screen for new users

class WelcomeScreen extends StatelessWidget {
  final bool isConnected;

  WelcomeScreen({this.isConnected});
  //list of pages to give the user info before start using the app
  final listPageViewModel = [
    PageViewModel(
      title: "Welcome to FCAI-HU App",
      bodyWidget: Text('Stay At Home'),
      image: FlareActor(
        'assets/welcome_animation.flr',
        alignment: Alignment.center,
        fit: BoxFit.cover,
        animation: 'Animations',
      ),
    ),
    PageViewModel(
      title: "You can Get all Courses At home",
      bodyWidget: Text('Stay At Home'),
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
        //navigate to main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PageHandler(
              isConnected: isConnected,
            ),
          ),
        );
      },
      onSkip: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //set first time to false
        prefs.setBool('firstTime', false);
        //navigate to main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PageHandler(
              isConnected: isConnected,
            ),
          ),
        );
      },
      //add skip button
      showSkipButton: true,
      skip: Text('skip'),
      next: Icon(Icons.navigate_next),
      done: const Text(
        "Done",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      //navigation dots decoration
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: ColorsScheme.purple,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/shared_screens/signup.dart';
import 'package:fcaihu/screens/shared_screens/user_profile.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:fcaihu/screens/student/enrolled_courses.dart';
import 'package:fcaihu/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //know if the shared prefs is loaded or not
  bool bLoaded = false;
  //know if it's first time to open the app
  bool bFirstTime = true;
  @override
  void initState() {
    super.initState();
    //get shared prefs at app start
    _getSharedPref();
  }

  // getting shared prefs before the start of the app
  _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sleep(Duration(seconds: 5));
    bFirstTime = prefs.getBool('firstTime') ?? true;
    setState(() {
      bLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          // get the splash then welcome or main
          bLoaded
              ? bFirstTime ? WelcomeScreen() : AvailableCourses()
              : SplashScreen(),
      //routes for all screens in the app
      routes: {
        AvailableCourses.id: (context) => AvailableCourses(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        EnrolledCourses.id: (context) => EnrolledCourses(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}

//splash screen widget

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      body: Center(
        child: RichText(
          text: TextSpan(
              text: 'FCAI',
              style: TextStyle(
                fontSize: 40,
                color: ColorsScheme.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' HU',
                  style: TextStyle(
                    color: ColorsScheme.purple,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/shared_screens/signup.dart';
import 'package:fcaihu/screens/shared_screens/user_profile.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:fcaihu/screens/student/enrolled_courses.dart';
import 'package:fcaihu/screens/welcome.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainApp(),
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

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //know if it's first time to open the app
  bool bFirstTime = true;

  @override
  void initState() {
    super.initState();
    //get shared prefs at app start
    _getSharedPref();
  }

  _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bFirstTime = prefs.getBool('firstTime') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffCEBDFF),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SplashScreen.navigate(
            name: 'assets/splash_screen_animation.flr',
            // get the splash then welcome or main
            next: (_) => bFirstTime ? WelcomeScreen() : AvailableCourses(),
            until: () => Future.delayed(Duration(seconds: 5)),
            startAnimation: 'Animations',
          ),
        ),
      ),
    );
  }
}

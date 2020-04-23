import 'package:connectivity/connectivity.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/models/user.dart';
import 'package:fcaihu/screens/shared_screens/About_Screens/About.dart';
import 'package:fcaihu/screens/shared_screens/ChatView/ChatListPageView.dart';
import 'package:fcaihu/screens/shared_screens/choose_profile_photo.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/shared_screens/signup.dart';
import 'package:fcaihu/screens/shared_screens/update_user_info.dart';
import 'package:fcaihu/screens/shared_screens/user_profile.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:fcaihu/screens/student/course_overview.dart';
import 'package:fcaihu/screens/student/enrolled_courses.dart';
import 'package:fcaihu/screens/welcome.dart';
import 'package:fcaihu/services/auth_service.dart';
import 'package:fcaihu/services/page_handler.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: MaterialApp(
        home: MainApp(),
        //routes for all screens in the app
        routes: {
          AvailableCourses.id: (context) => AvailableCourses(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          EnrolledCourses.id: (context) => EnrolledCourses(),
          ProfileScreen.id: (context) => ProfileScreen(),
          CourseOverview.id: (context) => CourseOverview(),
          PageHandler.id: (context) => PageHandler(),
          ChatListPageView.id: (context) => ChatListPageView(),
          ChooseProfilePhoto.id: (context) => ChooseProfilePhoto(),
          UpdateInfoScreen.id: (context) => UpdateInfoScreen(),
          About.id: (context) => About(),
        },
      ),
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
  //check internet connectivity
  bool bIsConnected = true;

  @override
  void initState() {
    super.initState();
    //get shared prefs at app start
    _getSharedPref();
    //check internet connectivity
    _checkInternetConnectivity();
  }

  _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('user_id');
    setState(() {
      bFirstTime = prefs.getBool('firstTime') ?? true;
    });
    if (userID != null) {
      User user = await AuthService.getUserWithID(userID, context);
      Provider.of<ProviderData>(context, listen: false).updateUser(user);
    }
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      bIsConnected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffCEBDFF),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SplashScreen.navigate(
            name: 'assets/second_splash_screen_animation.flr',
            // get the splash then welcome or main
            next: (_) => bFirstTime
                ? WelcomeScreen(isConnected: bIsConnected)
                : PageHandler(isConnected: bIsConnected),
            until: () => Future.delayed(Duration(seconds: 5)),
            startAnimation: 'Animations',
          ),
        ),
      ),
    );
  }
}

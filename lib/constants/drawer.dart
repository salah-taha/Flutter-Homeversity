import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/shared_screens/signup.dart';
import 'package:fcaihu/screens/shared_screens/user_profile.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:fcaihu/screens/student/enrolled_courses.dart';
import 'package:flutter/material.dart';

class DrawerAppBar extends StatelessWidget {
  final selectedPageColor = ColorsScheme.purple;
  final notSelectedColor = ColorsScheme.darkGrey;
  final selectedPage;
  DrawerAppBar({@required this.selectedPage});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorsScheme.brightPurple,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (selectedPage != ProfileScreen.id)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      else {
                        Navigator.pop(context);
                      }
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: ColorsScheme.brightPurple,
                        backgroundImage: NetworkImage(
                            'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/0fd6db77892127.5c94c32772e96.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Sara Ahmed',
                    style: TextStyle(
                      color: ColorsScheme.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: ColorsScheme.purple,
              ),
            ),
            ListTile(
              title: Text(
                'Enrolled Courses',
                style: TextStyle(
                  color: selectedPage == 'enrolledCourses'
                      ? selectedPageColor
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, EnrolledCourses.id);
              },
            ),
            ListTile(
              title: Text(
                'Available Courses',
                style: TextStyle(
                  color: selectedPage == AvailableCourses.id
                      ? selectedPageColor
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AvailableCourses.id);
              },
            ),
            ListTile(
              title: Text(
                'Chat Groups',
                style: TextStyle(
                  color: selectedPage == 'chatGroups'
                      ? selectedPageColor
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Login ~ SignUp',
                style: TextStyle(
                  color: selectedPage == LoginScreen.id ||
                          selectedPage == SignupScreen.id
                      ? selectedPageColor
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ListTile(
              title: Text(
                'About',
                style: TextStyle(
                  color: selectedPage == 'about'
                      ? selectedPageColor
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Report Bug',
                style: TextStyle(
                  color: selectedPage == 'reportBug'
                      ? Colors.red
                      : notSelectedColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

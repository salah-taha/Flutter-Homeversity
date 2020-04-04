import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/screens/shared_screens/ChatView/ChatListPageView.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/shared_screens/user_profile.dart';
import 'package:fcaihu/screens/student/available_courses.dart';
import 'package:fcaihu/screens/student/enrolled_courses.dart';
import 'package:fcaihu/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHandler extends StatefulWidget {
  static final String id = 'page_handler';
  @override
  _PageHandlerState createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler> {
  Widget selectedPage;
  String pageName;
  final selectedPageColor = ColorsScheme.purple;
  final notSelectedColor = ColorsScheme.darkGrey;

  @override
  void initState() {
    super.initState();
    selectedPage = ProfileScreen();
    pageName = 'Profile';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        backgroundColor: ColorsScheme.grey,
        title: Text(
          pageName,
          style: appBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: ColorsScheme.brightPurple,
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPage = ProfileScreen();
                      pageName = 'Profile';
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Provider.of<ProviderData>(context).user != null
                              ? ColorsScheme.purple
                              : ColorsScheme.darkGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 33,
                                  backgroundColor: ColorsScheme.brightPurple,
                                  backgroundImage: Provider.of<ProviderData>(
                                                      context)
                                                  .user
                                                  ?.imageUrl ==
                                              null ||
                                          Provider.of<ProviderData>(context)
                                                  .user
                                                  ?.imageUrl ==
                                              ' '
                                      ? AssetImage(
                                          'assets/images/user_placeholder.png')
                                      : NetworkImage(
                                          Provider.of<ProviderData>(context)
                                              .user
                                              .imageUrl),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                Provider.of<ProviderData>(context).user?.name ??
                                    'User',
                                style: TextStyle(
                                  color: ColorsScheme.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ColorsScheme.brightPurple,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: notSelectedColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Enrolled Courses',
                    style: TextStyle(
                      color: notSelectedColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedPage = EnrolledCourses();
                      pageName = 'Enrolled Courses';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Available Courses',
                    style: TextStyle(
                      color: notSelectedColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedPage = AvailableCourses();
                      pageName = 'Available Courses';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Chat Groups',
                    style: TextStyle(
                      color: notSelectedColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ChatListPageView.id);
                  },
                ),
                ListTile(
                  title: Text(
                    Provider.of<ProviderData>(context).user == null
                        ? 'Login ~ SignUp'
                        : 'LogOut',
                    style: TextStyle(
                      color: notSelectedColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    if (Provider.of<ProviderData>(context, listen: false)
                            .user ==
                        null) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, LoginScreen.id);
                    } else {
                      AuthService.logOut(context);
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'About',
                    style: TextStyle(
                      color: notSelectedColor,
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
                    'Contact Us',
                    style: TextStyle(
                      color: notSelectedColor,
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
        ),
      ),
      body: selectedPage,
    );
  }
}

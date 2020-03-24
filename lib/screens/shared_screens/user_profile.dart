import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/constants/drawer.dart';
import 'package:flutter/material.dart';

//selected bar action
enum selectedBar { notification, completed }

//user profile screen
class ProfileScreen extends StatefulWidget {
  //profile screen route id
  static final String id = 'profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //initializing selected bar
  selectedBar bar = selectedBar.notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        backgroundColor: ColorsScheme.grey,
        title: Text(
          'Profile',
          style: appBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: DrawerAppBar(
        selectedPage: ProfileScreen.id,
      ),
      backgroundColor: ColorsScheme.grey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: ClipPath(
                    clipper: ClippingClass(),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: NetworkImage(
                          'https://mewallpaper.com/thumbnail/abstract/8721-pyramids-illustration-wallpaper-image-high-quality.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsScheme.grey,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: ColorsScheme.grey,
                    backgroundImage: NetworkImage(
                      'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/0fd6db77892127.5c94c32772e96.jpg',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              'Sara Ahmed (Fake)',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsScheme.purple),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '15',
                        style: TextStyle(
                          color: ColorsScheme.purple,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'lectures',
                        style: TextStyle(
                          color: ColorsScheme.darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '1',
                        style: TextStyle(
                          color: ColorsScheme.purple,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'Level',
                        style: TextStyle(
                          color: ColorsScheme.darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorsScheme.grey,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorsScheme.grey,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -1),
                          color: ColorsScheme.brightPurple,
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: ColorsScheme.midPurple,
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              bar = selectedBar.notification;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 1,
                            child: Center(
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                  color: bar == selectedBar.notification
                                      ? ColorsScheme.purple
                                      : ColorsScheme.darkGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 25,
                          color: ColorsScheme.midPurple,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              bar = selectedBar.completed;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 1,
                            child: Center(
                                child: Text(
                              'Completed',
                              style: TextStyle(
                                color: bar == selectedBar.completed
                                    ? ColorsScheme.purple
                                    : ColorsScheme.darkGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        NotificationCard(),
                        NotificationCard(),
                        NotificationCard(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//notification card widget

class NotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorsScheme.brightPurple,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

//path clipper to round the image from bottom

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

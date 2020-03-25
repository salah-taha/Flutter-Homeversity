import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/constants/drawer.dart';
import 'package:flutter/material.dart';

//selected bar action
enum selectedBar { notification, completed }

//user profile screen
class ProfileScreen extends StatefulWidget {
  //profile screen route id
  static final String id = 'profileScreen';
  final profileImage;
  ProfileScreen({this.profileImage});

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
                        image: AssetImage('assets/images/dribbble.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://bennybox.dk/wp-content/uploads/2019/09/DTU_hero1_jan2019_02ef.jpg',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 50,
                    backgroundColor: ColorsScheme.grey,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: ColorsScheme.grey,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  placeholder: (context, url) => CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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
                  width: MediaQuery.of(context).size.width / 3,
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
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '560',
                        style: TextStyle(
                          color: ColorsScheme.purple,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Points',
                        style: TextStyle(
                          color: ColorsScheme.darkGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
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
                          offset: Offset(0, 2),
                          color: ColorsScheme.brightPurple,
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          offset: Offset(0, -2),
                          color: ColorsScheme.brightPurple,
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
                        NotificationCard(
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcROQiRJAyudzEi3VnK4IK78OnXTZOyGkA919uzky9IA6118SX2S',
                            title: 'New Lecture Added to PL Course',
                            isSeen: false,
                            date: ['24/3/2020', '9 AM']),
                        NotificationCard(
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSBG33Erje8D_l7KHaZ2EH3_W4jPAkVImXtjlIERkcZFmxrcWGk',
                            title: 'English Lecture at 8:00 PM Tommorow',
                            isSeen: true,
                            date: ['10/2/2020', '5 PM']),
                        NotificationCard(
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5qHwDOxOzqNSfM27gnoV_fklzMrD2k9EEtpGX3PQ6pzZK-F6y',
                            title: 'New Lecture Added to Math Course',
                            isSeen: true,
                            date: ['8/2/2020', '8 AM']),
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
  final String imageUrl;
  final String title;
  final bool isSeen;

  //index [0] is the date & index [1] is the time in hours
  final List<String> date;

  NotificationCard({this.imageUrl, this.isSeen, this.title, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorsScheme.grey,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundColor: ColorsScheme.brightPurple,
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.58,
                  height: 40,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: ColorsScheme.darkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          date[0],
                          style: TextStyle(
                            color: ColorsScheme.midPurple,
                          ),
                        ),
                        Text(
                          date[1],
                          style: TextStyle(
                            color: ColorsScheme.midPurple,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            isSeen
                ? SizedBox(
                    width: 26,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: ColorsScheme.blue,
                      radius: 5,
                    ),
                  )
          ],
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
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 20);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

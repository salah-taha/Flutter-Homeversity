import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//selected bar action
enum selectedBar { notification, newLectures }

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
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        child: Provider.of<ProviderData>(context).user == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('You Should Login to Your Account'),
                    RaisedButton(
                      color: ColorsScheme.purple,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ColorsScheme.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSQopdzqoXcW8XfVcODSjBZoGUfKokWvqbgwrvgfDZHylqN2iM_&usqp=CAU',
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
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
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      Provider.of<ProviderData>(context).user.name,
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
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            1,
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
                                      bar = selectedBar.newLectures;
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            1,
                                    child: Center(
                                        child: Text(
                                      'New Lectures',
                                      style: TextStyle(
                                        color: bar == selectedBar.newLectures
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
                          bar == selectedBar.notification
                              ? Expanded(
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
                              : Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    padding: EdgeInsets.all(10),
                                    children: <Widget>[
                                      NewLecture(
                                        courseName: 'PL Course',
                                        lectureTitle:
                                            'Pointers [Part 2], Structures [Part 2], and Unions in C',
                                        isCompleted: false,
                                      ),
                                      NewLecture(
                                        courseName: 'CS251 Course',
                                        lectureTitle:
                                            'From Domain to Requirements; Use-Case & Activity Diagrams',
                                        isCompleted: true,
                                      ),
                                      NewLecture(
                                        courseName: 'CS361 Course',
                                        lectureTitle:
                                            ' Knowledge Representation via Propositional & Predicate Calculi',
                                        isCompleted: true,
                                      ),
                                      NewLecture(
                                        courseName: 'CS361 Course',
                                        lectureTitle:
                                            'Problem Solving as Search - Blind/Uninformed vs. Heuristic/Informed Strategies',
                                        isCompleted: false,
                                      ),
                                      NewLecture(
                                        courseName: 'CS361 Course',
                                        lectureTitle:
                                            'Problem Solving as Search - Blind/Uninformed vs. Heuristic/Informed Strategies',
                                        isCompleted: false,
                                      ),
                                      NewLecture(
                                        courseName: 'CS251 Course',
                                        lectureTitle:
                                            'From Domain to Requirements; Use-Case & Activity Diagrams',
                                        isCompleted: true,
                                      ),
                                      NewLecture(
                                        courseName: 'CS361 Course',
                                        lectureTitle:
                                            ' Knowledge Representation via Propositional & Predicate Calculi',
                                        isCompleted: true,
                                      ),
                                      NewLecture(
                                        courseName: 'PL Course',
                                        lectureTitle:
                                            'Pointers [Part 2], Structures [Part 2], and Unions in C',
                                        isCompleted: false,
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
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

class NewLecture extends StatelessWidget {
  final String courseName;
  final String lectureTitle;
  final bool isCompleted;

  NewLecture({this.courseName, this.isCompleted, this.lectureTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorsScheme.grey,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 2,
                blurRadius: 5,
                color: ColorsScheme.brightPurple),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                courseName,
                style: TextStyle(
                  color: ColorsScheme.midPurple,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lectureTitle,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorsScheme.purple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Text(
                    isCompleted ? 'Completed' : 'Not Completed',
                    style: TextStyle(
                      color: ColorsScheme.darkGrey,
                      fontSize: 18,
                    ),
                  ),
                ),
                isCompleted
                    ? Icon(
                        Icons.check,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
              ],
            ),
          ],
        ));
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

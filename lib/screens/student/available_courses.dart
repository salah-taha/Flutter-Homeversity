import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcaihu/constants/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/constants.dart';

//available courses screen
class AvailableCourses extends StatelessWidget {
  //screen route id
  static String id = 'availableCourses';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer for navigation
      drawer: DrawerAppBar(
        selectedPage: id,
      ),
      backgroundColor: ColorsScheme.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: ColorsScheme.brightPurple,
              offset: Offset(0, 3),
              blurRadius: 5,
            )
          ]),
          child: AppBar(
            iconTheme: IconThemeData(color: ColorsScheme.purple),
            backgroundColor: ColorsScheme.grey,
            title: Text(
              'Available course',
              style: appBarTextStyle,
            ),
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CourseCard(
                  courseName: 'AI Course',
                  courseLevel: 'All',
                  teacherName: 'Amr S. Ghonaim',
                  lecturesNumber: 6,
                  teacherImageUrl:
                      'https://www.sketchappsources.com/resources/source-image/profile-illustration-gunaldi-yunus.png',
                  courseImageUrl:
                      'https://miro.medium.com/max/3200/1*QBxc5-QaDrLZV9VPHcqG0Q.png',
                ),
                CourseCard(
                  courseName: 'English Course',
                  courseLevel: '2',
                  teacherName: 'Ali Ghandour',
                  lecturesNumber: 10,
                  courseImageUrl:
                      'https://cdn.dribbble.com/users/1872109/screenshots/4871924/imagaination-illustration-800.jpg',
                  teacherImageUrl:
                      'https://gigantic.store/wp-content/uploads/2019/04/flat-design-character-HD.jpg',
                ),
                CourseCard(
                  courseName: 'PL Course',
                  courseLevel: '1',
                  teacherName: 'Mohammed El Saied',
                  lecturesNumber: 7,
                  courseImageUrl:
                      'https://cdn.dribbble.com/users/3281732/screenshots/6747768/samji_illustrator_2x.jpeg',
                  teacherImageUrl:
                      'https://cdn.dribbble.com/users/2424688/screenshots/5785083/amitabh.jpg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//courses card
class CourseCard extends StatelessWidget {
  final String courseName;
  final String teacherName;
  final String courseImageUrl;
  final String courseLevel;
  final String teacherImageUrl;
  final int lecturesNumber;

  CourseCard(
      {this.courseImageUrl,
      this.courseLevel,
      this.courseName,
      this.lecturesNumber,
      this.teacherImageUrl,
      this.teacherName});
  @override
  Widget build(BuildContext context) {
    //getting teacher name shortcut
    List teacherNameShortcutList = teacherName.split(' ');

    //setting teacher name shortcut
    String teacherNameShortcut;

    //if teacher name is more than 2 words
    if (teacherNameShortcutList.length >= 2) {
      teacherNameShortcut =
          teacherNameShortcutList.first[0].toString().toUpperCase() +
              '.' +
              teacherNameShortcutList.last[0].toString().toUpperCase();
    } else {
      teacherNameShortcut =
          teacherNameShortcutList.first[0].toString().toUpperCase();
    }

    return InkWell(
      onTap: () {
        //TODO navigate to course overview
      },
      splashColor: ColorsScheme.brightPurple,
      focusColor: ColorsScheme.brightPurple,
      highlightColor: ColorsScheme.grey,
      hoverColor: ColorsScheme.grey,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 18.0,
          top: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorsScheme.grey,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  color: ColorsScheme.brightPurple),
            ],
          ),
          height: 271,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                height: 160,
                imageUrl: courseImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: ColorsScheme.brightPurple,
                    image: courseImageUrl == null
                        ? null
                        : DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                  ),
                  height: 160,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: courseImageUrl != null
                      ? SizedBox()
                      : Center(
                          child: Text(
                            courseName,
                            style: TextStyle(
                              color: ColorsScheme.midPurple,
                              fontSize: 25,
                            ),
                          ),
                        ),
                ),
                placeholder: (context, url) => Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: teacherImageUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundColor: ColorsScheme.brightPurple,
                        radius: 40,
                        backgroundImage:
                            teacherImageUrl == null ? null : imageProvider,
                        child: teacherImageUrl == null
                            ? Text(
                                teacherNameShortcut,
                                style: TextStyle(
                                  color: ColorsScheme.midPurple,
                                  fontSize: 25,
                                ),
                              )
                            : SizedBox(),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          courseName,
                          style: TextStyle(
                            color: ColorsScheme.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Dr.$teacherName',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '$lecturesNumber lectures',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsScheme.grey,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsScheme.midPurple,
                            offset: Offset(2, 2),
                            spreadRadius: 1,
                            blurRadius: 2,
                          ),
                          BoxShadow(
                            color: ColorsScheme.white,
                            offset: Offset(-2, -2),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          courseLevel,
                          style: TextStyle(
                            color: ColorsScheme.midPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

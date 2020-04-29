import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/screens/student/course_progress.dart';
import 'package:fcaihu/services/courses_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrolledCourses extends StatelessWidget {
  static final String id = 'enrolledCourses';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
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
            : FutureBuilder(
                future: Firestore.instance
                    .collection('users')
                    .document(Provider.of<ProviderData>(context).user.id)
                    .collection('enrolledCourses')
                    .getDocuments(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Text('You did not Enroll any Course'),
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: Firestore.instance
                              .collection('available_courses')
                              .document(
                                  snapshot.data.documents[index].documentID)
                              .get(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> course) {
                            if (!course.hasData) {
                              return Container(
                                height: 280,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return FutureBuilder(
                              future: CoursesServices.getCourseLectures(context,
                                  snapshot.data.documents[index].documentID),
                              builder: (context, courseData) {
                                if (!courseData.hasData) {
                                  return Container(
                                    height: 280,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return CourseCard(
                                  courseName: course.data['courseName'],
                                  courseLevel: course.data['courseLevel'],
                                  teacherName: course.data['teacherName'],
                                  lecturesNumber: courseData
                                      .data['lectures'].documents.length,
                                  completedLecturesNumber: courseData
                                      .data['completedLectures']
                                      .documents
                                      .length,
                                  teacherImageUrl:
                                      course.data['teacherImageUrl'],
                                  courseImageUrl: course.data['courseImageUrl'],
                                  courseID: course.data.documentID,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
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
  final completedLecturesNumber;
  final String courseID;

  CourseCard({
    this.courseImageUrl,
    this.courseLevel,
    this.courseName,
    this.lecturesNumber,
    this.teacherImageUrl,
    this.teacherName,
    this.completedLecturesNumber,
    this.courseID,
  });
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

    //getting progress indicator size
    double courseProgress =
        ((completedLecturesNumber / lecturesNumber * 100) * 0.9) / 100;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Material(child: CourseProgress(courseID: courseID)),
          ),
        );
      },
      splashColor: ColorsScheme.brightPurple,
      focusColor: ColorsScheme.brightPurple,
      highlightColor: ColorsScheme.grey,
      hoverColor: ColorsScheme.grey,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            bottom: 13,
            top: 13,
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
            height: 281,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 160,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: courseImageUrl == null
                        ? Center(
                            child: Text(
                              courseName,
                              style: TextStyle(
                                color: ColorsScheme.midPurple,
                                fontSize: 25,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              courseName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorsScheme.purple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
                SizedBox(
                  height: 15,
                ),
                completedLecturesNumber != lecturesNumber
                    ? Container(
                        decoration: BoxDecoration(
                          color: ColorsScheme.midPurple,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 10,
                        width:
                            MediaQuery.of(context).size.width * courseProgress,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),

        //is course completed
        completedLecturesNumber == lecturesNumber
            ? Container(
                height: 281,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Container(
                    height: 60,
                    width: 180,
                    decoration: BoxDecoration(
                      color: ColorsScheme.purple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ]),
    );
  }
}

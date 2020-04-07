import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcaihu/screens/student/course_overview.dart';
import 'package:fcaihu/services/courses_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/constants.dart';

//available courses screen
class AvailableCourses extends StatelessWidget {
  //screen route id
  static String id = 'availableCourses';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: CoursesServices.getEnrolledAndAvailableCourses(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data['available'].documents.length,
                  itemBuilder: (context, index) {
                    bool isEnrolled = false;
                    snapshot.data['enrolled'].documents.forEach((element) {
                      if (element.documentID ==
                          snapshot
                              .data['available'].documents[index].documentID) {
                        isEnrolled = true;
                      }
                    });
                    return CourseCard.fromDoc(
                        doc: snapshot.data['available'].documents[index],
                        isEnrolled: isEnrolled);
                  },
                );
              },
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
  final String lecturesNumber;
  final String description;
  final String courseID;
  final bool isEnrolled;

  CourseCard(
      {this.courseImageUrl,
      this.courseLevel,
      this.courseName,
      this.lecturesNumber,
      this.teacherImageUrl,
      this.teacherName,
      this.description,
      this.courseID,
      this.isEnrolled});

  factory CourseCard.fromDoc({doc, isEnrolled}) {
    return CourseCard(
      courseName: doc['courseName'],
      teacherName: doc['teacherName'],
      courseImageUrl: doc['courseImageUrl'],
      courseLevel: doc['courseLevel'],
      teacherImageUrl: doc['teacherImageUrl'],
      lecturesNumber: doc['lecturesNumber'],
      description: doc['description'],
      courseID: doc.documentID,
      isEnrolled: isEnrolled,
    );
  }
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
        if (!isEnrolled) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseOverview(
                  courseImageUrl: courseImageUrl,
                  teacherImageUrl: teacherImageUrl,
                  courseTitle: courseName,
                  description: description,
                  teacherName: teacherName,
                  courseID: courseID),
            ),
          );
        }
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
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
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
            isEnrolled
                ? Container(
                    height: 271,
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
                            'Enrolled',
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
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/services/courses_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseProgress extends StatefulWidget {
  final String courseID;

  CourseProgress({this.courseID});

  @override
  _CourseProgressState createState() => _CourseProgressState();
}

class _CourseProgressState extends State<CourseProgress> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        title: Text(
          'Course Progress',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: ColorsScheme.grey,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: CoursesServices.getCourseLectures(
                      context, widget.courseID),
                  builder: (context, AsyncSnapshot<Map> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    QuerySnapshot lectures = snapshot.data['lectures'];
                    QuerySnapshot completedLectures =
                        snapshot.data['completedLectures'];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsScheme.purple,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: Text(
                              '$currentPage/${lectures.documents.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (page) {
                              setState(() {
                                currentPage = page + 1;
                              });
                            },
                            itemCount: lectures.documents.length,
                            itemBuilder: (context, index) {
                              bool isCompleted = false;
                              completedLectures.documents.forEach((element) {
                                if (element.documentID ==
                                    lectures.documents[index].documentID) {
                                  isCompleted = true;
                                }
                              });
                              return CourseProgressCard(
                                imageUrl: lectures.documents[index]['image'],
                                title: lectures.documents[index]['title'],
                                isCompleted: isCompleted,
                                videoUrl: lectures.documents[index]['video'],
                                pdfUrl: lectures.documents[index]['pdf'],
                                courseID: widget.courseID,
                                lectureID: lectures.documents[index].documentID,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}

class CourseProgressCard extends StatelessWidget {
  final bool isCompleted;
  final String title;
  final String imageUrl;
  final String videoUrl;
  final String pdfUrl;
  final String courseID;
  final String lectureID;

  CourseProgressCard({
    this.isCompleted,
    this.imageUrl,
    this.title,
    this.videoUrl,
    this.pdfUrl,
    this.lectureID,
    this.courseID,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Lecture(
                videoUrl: videoUrl,
                lectureName: title,
                pdfUrl: pdfUrl,
                lectureID: lectureID,
                courseID: courseID,
              ),
            ),
          );
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: ColorsScheme.grey,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: ColorsScheme.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        videoUrl == null
                            ? SizedBox.shrink()
                            : Container(
                                decoration: BoxDecoration(
                                  color: ColorsScheme.darkGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    'Video',
                                    style: TextStyle(
                                      color: ColorsScheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        pdfUrl == null
                            ? SizedBox.shrink()
                            : Container(
                                decoration: BoxDecoration(
                                  color: ColorsScheme.darkGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    'PDF',
                                    style: TextStyle(
                                      color: ColorsScheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
              isCompleted
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsScheme.purple.withAlpha(60),
                      ),
                      height: MediaQuery.of(context).size.height * 0.43,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsScheme.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class Lecture extends StatefulWidget {
  final String videoUrl;
  final String pdfUrl;
  final String courseID;
  final String lectureID;
  final String lectureName;

  Lecture(
      {@required this.lectureName,
      this.pdfUrl,
      this.videoUrl,
      this.courseID,
      this.lectureID});

  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  //video
  YoutubePlayerController _controller;

  //pdf
  String pathPDF = "";
  bool pdfReady = false;
  bool openingPdf = false;

  @override
  void initState() {
    super.initState();

    if (widget.videoUrl != null) {
      //video
      String videoId = YoutubePlayer.convertUrlToId(
        widget.videoUrl,
      );
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHideAnnotation: true,
          forceHD: false,
          enableCaption: true,
        ),
      );
    }
  }

  Future<File> createFileOfPdfUrl() async {
    final filename =
        widget.pdfUrl.substring(widget.pdfUrl.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(widget.pdfUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  void dispose() {
    if (widget.videoUrl != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        backgroundColor: ColorsScheme.grey,
        title: Text(
          widget.lectureName,
          style: appBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: InkWell(
              onTap: () async {
                await CoursesServices.completeLecture(
                    context, widget.courseID, widget.lectureID);
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseProgress(
                              courseID: widget.courseID,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: ColorsScheme.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.videoUrl == null
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      topActions: <Widget>[
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            _controller.metadata.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
            widget.pdfUrl == null
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (pdfReady) {
                          setState(() {
                            openingPdf = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFScreen(pathPDF),
                            ),
                          );
                        } else {
                          setState(() {
                            openingPdf = true;
                          });
                          await createFileOfPdfUrl().then((f) {
                            setState(() {
                              pathPDF = f.path;
                              pdfReady = true;
                            });
                          });
                          setState(() {
                            openingPdf = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFScreen(pathPDF),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorsScheme.grey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsScheme.brightPurple,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: openingPdf
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'open pdf file',
                                    style: TextStyle(
                                      color: ColorsScheme.purple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorsScheme.purple),
          backgroundColor: ColorsScheme.grey,
          title: Text(
            'Lecture name',
            style: appBarTextStyle,
          ),
          elevation: 0,
          centerTitle: true,
        ),
        path: pathPDF);
  }
}

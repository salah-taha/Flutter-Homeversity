import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:flutter/material.dart';

class FcaiHu extends StatefulWidget {
  final Function meetOurTeam;

  FcaiHu(this.meetOurTeam);
  @override
  _FcaiHuState createState() => _FcaiHuState();
}

class _FcaiHuState extends State<FcaiHu> {
  List imgList = [
    'assets/slider/2.jpg',
    'assets/slider/3.jpg',
    'assets/slider/4.jpg',
    'assets/slider/5.jpg',
    'assets/slider/6.jpg',
    'assets/slider/7.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsScheme.grey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsScheme.grey,
                  borderRadius: BorderRadius.circular(20),
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
                    BoxShadow(
                      offset: Offset(2, 0),
                      color: ColorsScheme.brightPurple,
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      offset: Offset(-2, 0),
                      color: ColorsScheme.brightPurple,
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'See FCAI HU',
                    style: TextStyle(
                      color: ColorsScheme.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            CarouselSlider(
              height: MediaQuery.of(context).size.height * 0.5,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            i,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SizedBox(),
                    );
                  },
                );
              }).toList(),
            ),
            InfoWidget(
              title: 'About FCAI HU',
              info:
                  'Helwan University approved on 7/18/1994 the establishment  of  Computer  science  and artificial intelligence faculty On 7/1/1995 the supreme  council of universities  approved this and it became  the first computer  science faculty  in Egypt, also the President’s Decree No. 419 of 1995 was established to establish the college to effectively contribute to the community services and provide an opportunity for everyone to learn computer technologies and information systems as to serve the development issues  and help in entering the information age by qualifying the manpower needed  for the labour market in the new era with its ability to compete in this field',
            ),
            InfoWidget(
                title: 'Vision',
                info:
                    'The Faculty of Computers and Information at Helwan University seeks scientific, practical and research excellence in the field of computers and information locally and regionally.'),
            InfoWidget(
                title: 'Mission',
                info:
                    'The college works on preparing an outstanding graduate who can compete in the local and regional job market in the fields of computers and information while contributing to serving the local community and enriching scientific research.'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: widget.meetOurTeam,
                color: ColorsScheme.purple,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Meet Our Team',
                    style: TextStyle(
                      color: Color(0xfff2f2f2),
                      fontSize: 16,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String info;

  InfoWidget({this.title, this.info});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsScheme.grey,
              borderRadius: BorderRadius.circular(20),
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
                BoxShadow(
                  offset: Offset(2, 0),
                  color: ColorsScheme.brightPurple,
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  offset: Offset(-2, 0),
                  color: ColorsScheme.brightPurple,
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: ColorsScheme.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsScheme.grey,
              borderRadius: BorderRadius.circular(20),
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
                BoxShadow(
                  offset: Offset(2, 0),
                  color: ColorsScheme.brightPurple,
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  offset: Offset(-2, 0),
                  color: ColorsScheme.brightPurple,
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorsScheme.darkGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

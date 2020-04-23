import 'package:fcaihu/screens/shared_screens/About_Screens/ui/Developers/Developer.dart';
import 'package:fcaihu/screens/shared_screens/About_Screens/ui/developerdetails/developer_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CookiePage extends StatelessWidget {



  List<Developer> _Developers = [


  Developer (avatar: "https://scontent.fcai19-1.fna.fbcdn.net/v/t1.0-9/47378646_1985352184879890_6745550041663930368_n.jpg?_nc_cat=106&_nc_sid=7aed08&_nc_ohc=48GDmYUveKMAX_UVjFD&_nc_ht=scontent.fcai19-1.fna&oh=82ae9dd19746d455434f3f439c15ea10&oe=5EC45358" ,
  name: "Abdelrahman Ragab", email: "abdoragab38@gmail.com",University: "Computer science,Helwan University" ),
   Developer (avatar:       'https://scontent.fcai19-1.fna.fbcdn.net/v/t1.0-9/s960x960/92133484_1963003350498212_3534471039058706432_o.jpg?_nc_cat=105&_nc_sid=85a577&_nc_ohc=ZAd23r99xRIAX92Wsto&_nc_ht=scontent.fcai19-1.fna&_nc_tp=7&oh=e9e1b264fb35499cdcadcdcd6f8bda53&oe=5EC624AA',
        name: "Salah Taha", email: "salahTaha@gmail.com",University: "Giza,Helwan University" )


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Flutter Developer', 'Abdelrahman Ragab', 'https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-9/47378646_1985352184879890_6745550041663930368_n.jpg?_nc_cat=106&_nc_sid=7aed08&_nc_ohc=jBnnlIW3isQAX9z0lIS&_nc_ht=scontent-cdt1-1.xx&oh=b9113c77ef621ed40d152e0d6762ac8c&oe=5EC847D8',
                       context),
                  _buildCard('Flutter Developer', 'Salah Taha', 'https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-9/s960x960/92133484_1963003350498212_3534471039058706432_o.jpg?_nc_cat=105&_nc_sid=85a577&_nc_ohc=ZAd23r99xRIAX-fbQGS&_nc_ht=scontent-cdt1-1.xx&_nc_tp=7&oh=0e0ebf862c07dd7889cab20d0ac3a939&oe=5EC624AA',
                     context),
                  _buildCard('Web Developer ', 'Saaed',
                      'https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-9/s960x960/92133484_1963003350498212_3534471039058706432_o.jpg?_nc_cat=105&_nc_sid=85a577&_nc_ohc=ZAd23r99xRIAX-fbQGS&_nc_ht=scontent-cdt1-1.xx&_nc_tp=7&oh=0e0ebf862c07dd7889cab20d0ac3a939&oe=5EC624AA',
                       context),

                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(String Title, String Name, String imgPath,  context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {


              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DeveloperDetailsPage(_Developers[0],avatarTag: 1)

                  ))

              ;
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      ),


                  Container(
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          child:CircleAvatar(
                            backgroundImage:  NetworkImage(imgPath),
                            radius: 50.0,
                          ),
                        )),
                  SizedBox(height: 7.0),
                  Text(Name,
                      style: TextStyle(
                          color: Colors.deepPurple[800],
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(Title,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           SignInButton(
                              Buttons.LinkedIn,
                              onPressed: () {},
                              mini: true,
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              onPressed: () {},
                              mini: true,
                            ),
                            SignInButton(
                              Buttons.Twitter,
                              onPressed: () {},
                              mini: true,

                            ),
                            ],

                          ))
                ])
            )
        )
    );
  }
}




import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/About_Screens/ui/Developers/Developer.dart';
import 'package:fcaihu/screens/shared_screens/About_Screens/ui/developerdetails/developer_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final List<Developer> _Developers = [
    Developer(
      avatar: "assets/images/abdoRagab.jpg",
      name: "Abdelrahman Ragab",
      email: "abdoragab38@gmail.com",
      university: "Computer science,Helwan University",
      address: "Maadi,Cairo",
      age: '21',
      description: [
        'Abdelrahman Ragab, Level 3',
        'Worked before as',
        '1-Web Application Developer at Nat solution.',
        '2-Freelance Flutter Developer.',
        '3-Machine learning intern at inetworks.',
      ],
      about:
          'Data science self learner with a great passion to learn and work in this field with a demonstrated history of working in the non-profit organization management industry. Skilled in Coding, Public Speaking, Microsoft Office, Research, Teamwork, and Leadership.',
      portfolioImagesUrls: [
        'assets/images/salah_1.png',
        'assets/images/salah_2.png',
//        'assets/images/salah_3.png',
//        'assets/images/salah_4.png',
        'assets/images/salah_5.png',
        'assets/images/salah_6.png',
        'assets/images/salah_7.png',
        'assets/images/salah_8.png',
      ],
      facebookPage: 'https://www.facebook.com/abdo.mohamed.374',
      githubPage: 'https://github.com/AbdelrahmanRagab38',
      twitterPage: 'https://twitter.com/A_R_M_M_S',
      whatsAppNumber: '+201208648921',
      phoneNumber: '+201155400075',
      title: 'Software Engineer',
    ),
    Developer(
      avatar: 'assets/images/salahTaha.jpg',
      name: "Salah Taha",
      email: "salahtaha065@gmail.com",
      university: "Computer science,Helwan University",
      address: 'Nahia,Giza',
      facebookPage: 'https://www.facebook.com/salahtahaabohemed',
      about:
          'Computer Scince Student who has a great desire to be milestone in Software Engeneering Field',
      whatsAppNumber: '+201063851921',
      phoneNumber: '+201033046302',
      twitterPage: 'https://twitter.com/as_motion',
      githubPage: 'https://github.com/salah-taha',
      portfolioImagesUrls: [
        'assets/images/salah_1.png',
        'assets/images/salah_2.png',
        'assets/images/salah_3.png',
//        'assets/images/salah_4.png',
        'assets/images/salah_5.png',
        'assets/images/salah_6.png',
//        'assets/images/salah_7.png',
        'assets/images/salah_8.png',
      ],
      description: [
        'Salah Taha, Level 1',
        'Worked before as',
        '1-Flutter Developer Freelancer.',
        '2-Motion Graphics Freelancer.',
        '3-Graphic Designer Freelancer.',
      ],
      age: '20',
      title: 'Software Engineer',
    ),
    Developer(
      avatar: 'assets/images/saiedAhmed.jpg',
      name: "Saied Ahmed",
      email: "saiedahmedsaied821@gmail.com",
      university: "Computer science,Helwan University",
      address: 'Nahia,Giza',
      facebookPage: 'https://www.facebook.com/profile.php?id=100006625578162',
      about:
          'Computer Scince Student who has a great desire to be milestone in Software Engeneering Field',
      whatsAppNumber: '+201159097857',
      phoneNumber: '+201159097857',
//      twitterPage: 'https://twitter.com/as_motion',
      githubPage: 'https://github.com/siaed',
      portfolioImagesUrls: [
        'assets/images/salah_1.png',
        'assets/images/salah_2.png',
        'assets/slider/2.jpg',
        'assets/images/salah_3.png',
        'assets/images/salah_4.png',
//        'assets/images/salah_5.png',
//        'assets/images/salah_6.png',
//        'assets/images/salah_7.png',

        'assets/images/salah_8.png',
      ],
      description: [
        'Saied Ahmed, Level 1',
        'Worked before as',
        '1-Flutter Developer Freelancer.',
        '2-Web Developer Freelancer.',
        '3-Web Designer Freelancer.',
      ],
      age: '19',
      title: 'Web Developer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.78,
            children: <Widget>[
              _buildCard(_Developers[0], context),
              _buildCard(_Developers[1], context),
              _buildCard(_Developers[2], context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Developer dev, context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DeveloperDetailsPage(dev, avatarTag: 1)));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: ColorsScheme.white),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Container(
                      height: 75.0,
                      width: 75.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(dev.avatar),
                        radius: 50.0,
                        backgroundColor: Colors.white,
                      ),
                    )),
                    SizedBox(height: 7.0),
                    Text(dev.name,
                        style: TextStyle(
                            color: Colors.deepPurple[800],
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Text(dev.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Container(color: Color(0xFFEBEBEB), height: 1.0)),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SignInButton(
                            Buttons.GitHub,
                            onPressed: () async {
                              final url = dev.githubPage;

                              if (await canLaunch(url)) {
                                await launch(url, forceSafariVC: true);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            mini: true,
                          ),
                          SignInButton(
                            Buttons.Facebook,
                            onPressed: () async {
                              final url = dev.facebookPage;

                              if (await canLaunch(url)) {
                                await launch(url, forceSafariVC: true);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            mini: true,
                          ),
                          SignInButton(
                            Buttons.Twitter,
                            onPressed: () async {
                              final url = dev.twitterPage;

                              if (await canLaunch(url)) {
                                await launch(url, forceSafariVC: true);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            mini: true,
                          ),
                        ],
                      ),
                    )
                  ]),
            )));
  }
}

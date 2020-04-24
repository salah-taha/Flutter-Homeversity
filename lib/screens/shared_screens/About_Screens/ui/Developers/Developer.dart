import 'package:meta/meta.dart';

//the data that wew need to preview
class Developer {
  Developer({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.university,
    @required this.description,
    @required this.address,
    @required this.age,
    @required this.portfolioImagesUrls,
    @required this.phoneNumber,
    @required this.about,
    @required this.whatsAppNumber,
    @required this.facebookPage,
    @required this.githubPage,
    @required this.twitterPage,
    @required this.title,
  });

  final String avatar;
  final String name;
  final String email;
  final String university;
  final String age;
  final String phoneNumber;
  final String address;
  final String whatsAppNumber;
  final List<String> description;
  final List<String> portfolioImagesUrls;
  final String about;
  final String facebookPage;
  final String githubPage;
  final String twitterPage;
  final String title;
}

import 'package:fcaihu/screens/shared_screens/About_Screens/ui/Developers/Developer.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import 'diagonally_cut_colored_image.dart';

class DeveloperDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/images/BK.jpg';

  DeveloperDetailHeader(
    this.developer, {
    @required this.avatarTag,
  });

  final Developer developer;
  final Object avatarTag;

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB8338f4),
    );
  }

  Widget _buildAvatar() {
    return new Hero(
      tag: avatarTag,
      child: CircleAvatar(
        radius: 52,
        backgroundColor: Colors.white,
        child: new CircleAvatar(
          backgroundImage: new AssetImage(developer.avatar),
          radius: 50.0,
        ),
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('${developer.age} years old', style: followerStyle),
              new Text(
                ' | ',
                style: followerStyle.copyWith(
                    fontSize: 24.0, fontWeight: FontWeight.normal),
              ),
              new Text(developer.phoneNumber, style: followerStyle),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                developer.email,
                style: followerStyle,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _createPillButton(
            'Call ME',
            backgroundColor: Colors.indigo,
            textColor: Colors.white,
            onClicked: () => launch("tel://${developer.phoneNumber}"),
          ),
          new DecoratedBox(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white30),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: _createPillButton('Talk with me', textColor: Colors.white,
                onClicked: () async {
              final url = 'https://wa.me/${developer.whatsAppNumber}';

              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: true);
              } else {
                throw 'Could not launch $url';
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _createPillButton(String text,
      {Color backgroundColor = Colors.transparent,
      Color textColor = Colors.white70,
      Function onClicked}) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        height: 50,
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: onClicked,
        child: new Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.37,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
              _buildActionButtons(theme),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}

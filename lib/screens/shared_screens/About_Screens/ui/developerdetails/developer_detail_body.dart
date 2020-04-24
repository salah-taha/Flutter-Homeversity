import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/About_Screens/ui/Developers/Developer.dart';
import 'package:flutter/material.dart';

class DeveloperDetailBody extends StatelessWidget {
  DeveloperDetailBody(this.developer);
  final Developer developer;

  Widget _buildLocationInfo(TextTheme textTheme) {
    return new Row(
      children: <Widget>[
        new Icon(
          Icons.place,
          color: Colors.white,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            developer.address,
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: color,
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 20.0,
        ),
        radius: 20.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          developer.name,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: developer.description.map((element) {
              return Text(
                element,
                textAlign: TextAlign.start,
                style: textTheme.body1
                    .copyWith(color: Colors.white70, fontSize: 16.0),
              );
            }).toList(),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Row(
            children: <Widget>[
              _createCircleBadge(Icons.android, ColorsScheme.purple),
              _createCircleBadge(Icons.code, theme.accentColor),
              _createCircleBadge(Icons.web, Colors.white12),
            ],
          ),
        ),
      ],
    );
  }
}

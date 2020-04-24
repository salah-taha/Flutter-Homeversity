import 'package:fcaihu/screens/shared_screens/About_Screens/ui/Developers/Developer.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'developer_detail_body.dart';
import 'footer/developer_detail_footer.dart';
import 'header/developer_detail_header.dart';

class DeveloperDetailsPage extends StatefulWidget {
  DeveloperDetailsPage(
    this.developer, {
    @required this.avatarTag,
  });

  final Developer developer;
  final Object avatarTag;

  @override
  _DeveloperDetailsPageState createState() => _DeveloperDetailsPageState();
}

class _DeveloperDetailsPageState extends State<DeveloperDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: linearGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DeveloperDetailHeader(
                widget.developer,
                avatarTag: widget.avatarTag,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: new DeveloperDetailBody(widget.developer),
              ),
              DeveloperShowcase(widget.developer),
            ],
          ),
        ),
      ),
    );
  }
}

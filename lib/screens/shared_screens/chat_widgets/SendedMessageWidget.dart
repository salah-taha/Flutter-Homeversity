import 'package:fcaihu/constants/constants.dart';
import 'package:flutter/material.dart';
//import 'package:simple_chat_application/Global/Colors.dart' as myColors;

class SendedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const SendedMessageWidget({
    Key key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 50.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Container(
            color: ColorsScheme.purple,
            // margin: const EdgeInsets.only(left: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: ColorsScheme.brightPurple,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 10,
                  child: Text(
                    time,
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.6)),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

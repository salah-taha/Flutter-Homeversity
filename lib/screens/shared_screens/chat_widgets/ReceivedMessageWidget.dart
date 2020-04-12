import 'package:fcaihu/constants/constants.dart';
import 'package:flutter/material.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  final String senderName;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.senderName,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding:
          const EdgeInsets.only(right: 120.0, left: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsScheme.brightPurple,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: ColorsScheme.purple,
                blurRadius: 3,
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 8.0, top: 8.0, bottom: 15.0),
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 10,
                child: Text(
                  senderName + ' ' + time,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.6)),
                ),
              )
            ]),
          ),
        ),
      ),
    ));
  }
}

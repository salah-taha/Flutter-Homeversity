import 'package:fcaihu/screens/shared_screens/ChatView/ChatPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:simple_chat_application/Global/Colors.dart' as myColors;

class ChatListViewItem extends StatelessWidget {
  final image;
  final String name;
  final String lastMessage;
  final String time;
  final bool hasUnreadMessage;
  final int newMessageCount;
  const ChatListViewItem({
    Key key,
    this.image,
    this.name,
    this.lastMessage,
    this.time,
    this.hasUnreadMessage,
    this.newMessageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        time,
                        style: TextStyle(fontSize: 12),
                      ),
                      hasUnreadMessage
                          ? Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                  color: Color(0xff4668fd),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              child: Center(
                                  child: Text(
                                newMessageCount.toString(),
                                style: TextStyle(fontSize: 11),
                              )),
                            )
                          : SizedBox()
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPageView(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Divider(
            endIndent: 12.0,
            indent: 12.0,
            height: 0,
          ),
        ],
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () {},
        ),
      ],
    );
  }
}

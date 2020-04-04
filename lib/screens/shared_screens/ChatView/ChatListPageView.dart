import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/chat_widgets/ChatListViewItem.dart';
import 'package:flutter/material.dart';
//import 'package:simple_chat_application/Global/Colors.dart' as myColors;

class ChatListPageView extends StatefulWidget {
  static final String id = 'ChatListPageView';

  @override
  _ChatListPageViewState createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<ChatListPageView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    /* Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    /* if (isLoading == true) {
      return  CircularProgressIndicator();
    } else {*/
    return Container(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: ColorsScheme.purple,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'chats',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Container(
          color: ColorsScheme.purple,
          child: Container(
            decoration: BoxDecoration(
              color: ColorsScheme.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                ChatListViewItem(
                  hasUnreadMessage: true,
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/1338391/screenshots/3834956/cool_man_dribbble.jpg'),
                  lastMessage:
                      "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                  name: "Level 1 ",
                  newMessageCount: 8,
                  time: "19:27 PM",
                ),
                ChatListViewItem(
                  hasUnreadMessage: true,
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/1338391/screenshots/4836841/dribbble.jpg'),
                  lastMessage:
                      "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                  name: "Level 2",
                  newMessageCount: 5,
                  time: "19:27 PM",
                ),
                ChatListViewItem(
                  hasUnreadMessage: false,
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/1338391/screenshots/3906995/dribbble.jpg'),
                  lastMessage:
                      "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                  name: "Level 3",
                  newMessageCount: 0,
                  time: "19:27 PM",
                ),
                ChatListViewItem(
                  hasUnreadMessage: false,
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/1338391/screenshots/3845026/urban_dribbble.jpg'),
                  lastMessage:
                      "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                  name: "Level 4",
                  newMessageCount: 0,
                  time: "19:27 PM",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//}

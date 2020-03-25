import 'package:fcaihu/screens/shared_screens/widgets/ChatListViewItem.dart';
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
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.deepPurple,
            ),
            centerTitle: true,
            title: Text(
              'chats',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: Container(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffabafc3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  )),
              child: ListView(
                children: <Widget>[
                  ChatListViewItem(
                    hasUnreadMessage: true,
                    image: AssetImage('assets/images/person1.jpg'),
                    lastMessage:
                        "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Level 1 ",
                    newMesssageCount: 8,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: true,
                    image: AssetImage('assets/images/person2.png'),
                    lastMessage:
                        "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Level 2",
                    newMesssageCount: 5,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person3.jpg'),
                    lastMessage:
                        "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Level 3",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person4.png'),
                    lastMessage:
                        "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Level 4",
                    newMesssageCount: 0,
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

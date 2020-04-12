import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/models/user.dart';
import 'package:fcaihu/screens/shared_screens/chat_widgets/ChatListViewItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:simple_chat_application/Global/Colors.dart' as myColors;

class ChatListPageView extends StatefulWidget {
  static final String id = 'ChatListPageView';

  @override
  _ChatListPageViewState createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<ChatListPageView> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<ProviderData>(context).user;
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
            'Chatting Rooms',
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
              child: user == null
                  ? Center(
                      child: Text('You Must Login To See Chat'),
                    )
                  : FutureBuilder(
                      future: Firestore.instance
                          .collection('chatRooms')
                          .getDocuments(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: Firestore.instance
                                  .collection('chatRooms')
                                  .document(
                                      snapshot.data.documents[index].documentID)
                                  .collection('messages')
                                  .orderBy('time', descending: true)
                                  .limit(1)
                                  .getDocuments(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot>
                                      messagesSnapshot) {
                                if (!messagesSnapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorsScheme.darkGrey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  );
                                }
                                var lastMessageText = messagesSnapshot
                                    .data.documents.last['message'];
                                var lastMessageTime =
                                    DateFormat('hh:mm a').format(
                                  (messagesSnapshot.data.documents.last['time']
                                          as Timestamp)
                                      .toDate(),
                                );

                                return ChatListViewItem(
                                  roomID:
                                      snapshot.data.documents[index].documentID,
                                  hasUnreadMessage: false,
                                  image: NetworkImage(snapshot
                                      .data.documents[index]['imageUrl']),
                                  lastMessage: lastMessageText,
                                  name: snapshot.data.documents[index]['name'],
                                  newMessageCount: 8,
                                  time: lastMessageTime,
                                );
                              },
                            );
                          },
                        );
                      },
                    )),
        ),
      ),
    );
  }
}

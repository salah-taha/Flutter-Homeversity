import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/models/user.dart';
import 'package:fcaihu/screens/shared_screens/chat_widgets/ReceivedMessageWidget.dart';
import 'package:fcaihu/screens/shared_screens/chat_widgets/SendedMessageWidget.dart';
import 'package:fcaihu/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:simple_chat_application/Global/Colors.dart' as myColors;

class ChatPageView extends StatefulWidget {
  static final String id = 'ChatPageView';
  final String roomID;
  final String roomName;
  final image;

  const ChatPageView({
    Key key,
    this.roomName,
    this.roomID,
    this.image,
  }) : super(key: key);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  TextEditingController _text = new TextEditingController();
  var childList = <Widget>[];

  @override
  void initState() {
    super.initState();
    childList.add(Align(
        alignment: Alignment(0, 0),
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: ColorsScheme.darkGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Center(
              child: Text(
            "Today",
            style: TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
        )));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'Hello',
        time: '21:36 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'How are you? What are you doing?',
        time: '21:36 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: ReceivedMessageWidget(
        content: 'Hello, Mohammad.I am fine. How are you?',
        time: '22:40 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content:
            'I am good. Can you do something for me? I need your help my bro in PL2.',
        time: '22:40 PM',
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<ProviderData>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                    child: Container(
                      color: ColorsScheme.purple,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.roomName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundImage: widget.image,
                                radius: 20,
                              ),
                              padding: const EdgeInsets.all(0.0),
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorsScheme.brightPurple,
                                        blurRadius: 5.0,
                                        spreadRadius: 1,
                                        offset: Offset(0.0, 0.0))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.black54,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    // height: 500,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        //color: Colors.deepPurple,
                        image: DecorationImage(
                            image: AssetImage("assets/images/Cbk.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.linearToSrgbGamma()),
                      ),
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('chatRooms')
                            .document(widget.roomID)
                            .collection('messages')
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            reverse: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              var message = snapshot.data.documents[index];
                              var messageTime = DateFormat('hh:mm a')
                                  .format(
                                      (message['time'] as Timestamp).toDate())
                                  .toString();
                              if (message['senderID'] == currentUser.id) {
                                return SendedMessageWidget(
                                  content: message['message'],
                                  time: messageTime,
                                );
                              } else {
                                return ReceivedMessageWidget(
                                  senderName: message['senderName'],
                                  content: message['message'],
                                  time: messageTime,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.black26),
                  // SizedBox(
                  //   height: 50,
                  Container(
                    color: Colors.white,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        maxLines: 20,
                        controller: _text,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              if (_text.text.isNotEmpty) {
                                ChatServices.sendMessage(
                                    senderName: currentUser.name,
                                    senderID: currentUser.id,
                                    message: _text.text,
                                    roomID: widget.roomID);
                                _text.clear();
                              }
                            },
                          ),
                          border: InputBorder.none,
                          hintText: "enter your message",
                        ),
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

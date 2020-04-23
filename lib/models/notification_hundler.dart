import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebaseMessaging(BuildContext context) async {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.subscribeToTopic('globalTopic');
    firebaseCloudMessagingListeners(context);
  }

  void userLoginOrRegister(String userID, BuildContext context) async {
    _firebaseMessaging = FirebaseMessaging();
    var userToken = await _firebaseMessaging.getToken();
    await _addUserToken(userToken, userID);
    firebaseCloudMessagingListeners(context);
  }

  _addUserToken(String userToken, String userID) async {
    await Firestore.instance
        .collection('users')
        .document(userID)
        .collection('tokens')
        .document(userToken)
        .setData({});
  }

  userLogOut(String userID) async {
    _firebaseMessaging = FirebaseMessaging();
    var userToken = await _firebaseMessaging.getToken();
    await _removeUserToken(userToken, userID);
  }

  _removeUserToken(String userToken, String userID) async {
    await Firestore.instance
        .collection('users')
        .document(userID)
        .collection('tokens')
        .document(userToken)
        .delete();
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    if (Platform.isIOS) iosPermission();

    _firebaseMessaging.getToken();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on Message ${message['notification']}');
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 180.0,
                    width: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            message['notification']['title'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            message['notification']['body'],
                            style: TextStyle(
                              fontSize: 17,
                              color: ColorsScheme.purple,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}

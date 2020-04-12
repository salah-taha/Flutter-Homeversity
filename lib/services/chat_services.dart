import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static sendMessage(
      {String senderName,
      String roomID,
      String message,
      String senderID}) async {
    await Firestore.instance
        .collection('chatRooms')
        .document(roomID)
        .collection('messages')
        .add({
      'message': message,
      'senderID': senderID,
      'senderName': senderName,
      'time': DateTime.now()
    });
  }
}

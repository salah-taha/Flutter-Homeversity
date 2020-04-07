import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String level;
  final String points;
  final int completedLectures;
  final String email;
  final String imageUrl;
  final String uniID;

  User({
    this.name,
    this.id,
    this.completedLectures,
    this.level,
    this.points,
    this.email,
    this.imageUrl,
    this.uniID,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
        name: doc['name'],
        level: doc['level'],
        points: doc['points'],
        completedLectures: doc['completedLectures'],
        id: doc.documentID,
        email: doc['email'],
        imageUrl: doc['imageUrl'],
        uniID: doc['id']);
  }
}

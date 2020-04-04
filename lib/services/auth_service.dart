import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  //signUp Method
  static Future<String> signUp({
    String userName,
    String id,
    String level,
    String email,
    String password,
    BuildContext context,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _user = result.user;
      _firestore.collection('users').document(_user.uid).setData({
        'name': userName,
        'level': level,
        'points': '0',
        'completedLectures': '0',
        'uniID': id,
        'email': email,
        'imageUrl': ' '
      });

      User user = User(
          name: userName,
          level: level,
          id: result.user.uid,
          points: '0',
          completedLectures: '0',
          email: email,
          imageUrl: ' ',
          uniID: id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', user.id);
      Provider.of<ProviderData>(context, listen: false).updateUser(user);
    } catch (e) {
      switch (e.message) {
        case 'The email address is already in use by another account.':
          return "this email is used before";
          break;
        default:
          return 'there is an error';
      }
    }
    return null;
  }

  static Future<String> login(
      {String email, String password, BuildContext context}) async {
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result == null) {
        throw 'The password is invalid or the user does not have a password.';
      }
      User user = await getUserWithID(result.user.uid, context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', user.id);
      Provider.of<ProviderData>(context, listen: false).updateUser(user);
    } catch (e) {
      switch (e.message) {
        case 'The password is invalid or the user does not have a password.':
          return 'Email or Password is incorrect';
          break;
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'Email or Password is incorrect';
          break;
        default:
          return 'there is an error';
      }
    }
    return null;
  }

  static Future<User> getUserWithID(String id, BuildContext context) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').document(id).get();
    User user = User.fromDoc(userDoc);
    return user;
  }
}

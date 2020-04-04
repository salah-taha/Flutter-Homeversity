import 'package:fcaihu/models/user.dart';
import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  User user;

  void updateUser(User user) {
    this.user = user;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class User {
  final String userId; // 用户ID
  final String username;
  final String email;
  

  User({
    required this.userId,
    required this.username,
    required this.email,
  });
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setUserFromSavedData(String userId, String username, String email) {
    _user = User(userId: userId, username: username, email: email);
    notifyListeners();
  }

}

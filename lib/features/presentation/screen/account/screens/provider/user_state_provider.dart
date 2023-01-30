import 'package:flutter/material.dart';

class UserStateProvider extends ChangeNotifier {
  UserType _userType = UserType.student;

  UserType get userType => _userType;

  void setUserType(UserType user) {
    _userType = user;
    notifyListeners();
  }
}

enum UserType { student, teacher, admin }

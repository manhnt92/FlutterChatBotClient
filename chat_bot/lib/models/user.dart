import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:flutter/material.dart';

class User {

  static final User instance = User._internal();
  factory User() => instance;
  User._internal();

  int userId = 0;
  int freeMessageLeft = 0;
  bool isPurchased = false;
  String currentPackage = "";

  void onLoginResponse(PBLoginResponse loginResponse) {
    userId = loginResponse.user.dbId;
    freeMessageLeft = loginResponse.user.freeMsgLeft;
    isPurchased = loginResponse.user.isPurchased;
    currentPackage = loginResponse.user.currentPackage;
    debugPrint('login success: id=$userId, freeMsgLeft: $freeMessageLeft, isPurchased: $isPurchased');
  }

  void updateUserInfo(PBUser userInfo) {
    userId = userInfo.dbId;
    freeMessageLeft = userInfo.freeMsgLeft;
    isPurchased = userInfo.isPurchased;
    currentPackage = userInfo.currentPackage;
  }

}
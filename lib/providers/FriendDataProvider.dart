import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

class FriendProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _friends = [];
  List<Map<String, dynamic>> get friends => _friends;

  FriendProvider() {
    loadFriends(FirebaseAuth.instance.currentUser);
  }

  // ฟังก์ชันโหลดข้อมูลเพื่อน
  void loadFriends(var userId) {
    // ใช้ฟังก์ชัน getFriendList เพื่อดึงข้อมูลเพื่อน
    getFriendList(userId).listen((arg) {
      _friends = arg;
      notifyListeners();
    });
  }
}

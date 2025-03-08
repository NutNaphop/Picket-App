import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locket_mockup/service/CRUD.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _userData;

  
  Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData(String uid) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
        var userInfo = await getUser(uid) as Map<String, dynamic>;

      if (userInfo != null) {
        _userData = userInfo  ;
        notifyListeners();
      } else {
        print('No user data found for this UID');
        _userData = null; // ทำให้แน่ใจว่าค่าจะเป็น null ถ้าไม่พบข้อมูล
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
      _userData = null; // ถ้ามีข้อผิดพลาดเกิดขึ้น
      notifyListeners();
    }
  } else {
    print('No user logged in');
    _userData = null; // ถ้าไม่มีผู้ใช้ล็อกอิน
    notifyListeners();
  }
}


void logout() {
  _userData = null; // เคลียร์ข้อมูล
  notifyListeners();
}


  void updateUserData(Map<String, dynamic> newUserData) {
    _userData = newUserData;
    notifyListeners();
  }
}

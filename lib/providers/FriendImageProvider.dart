import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';

class ImageFriendProvider with ChangeNotifier {
  bool _isLoading = true;
  List<Map<String, dynamic>> _allImages = [];
  List<Map<String, dynamic>> _allImagesTemp = [];
  String? filterBy; // ตัวแปรสำหรับเก็บ ID ของเพื่อนที่เลือก
  int _prevImageCount = 0; // ✅ เก็บจำนวนรูปภาพก่อนหน้
  List<Map<String, dynamic>> get images {
    // ✅ ถ้ามีการกรอง จะแสดงเฉพาะรูปของเพื่อนที่เลือก
    if (filterBy != null) {
      return _allImages.where((img) => img["by"] == filterBy).toList();
    }
    return _allImagesTemp;
  }

  bool get isLoading => _isLoading;
  
  ImageFriendProvider() {
    fetchImages();
  }

  // ฟังก์ชันรับข้อมูลจาก getImageFriend ซึ่งจะคืนค่า Stream
  void fetchImages() {
    getImageFriend().listen((newImages) async {
      if (newImages.length == _prevImageCount) return;

      _allImagesTemp = [];

      // สำหรับแต่ละ image, ไปดึงข้อมูลโปรไฟล์จาก users collection
      for (var imageDoc in newImages) {
        var userId = imageDoc.data()["by"]; // ดึง userId ของเพื่อนที่แชร์ภาพ
        var userProfile = await fetchUserProfile(userId); // ดึงโปรไฟล์ของเพื่อน
        _allImagesTemp.add({
          "image": imageDoc.data(), // เก็บข้อมูลของภาพ
          "profile": userProfile["profile"], // เก็บโปรไฟล์
          "name": userProfile["name"], // เก็บชื่อ
          "by": userId, // เก็บ userId
        });
      }

      _allImages =
          _allImagesTemp; // อัปเดต `_allImages` ด้วยข้อมูลที่มีการปรับปรุง
      _isLoading = false;
      notifyListeners(); // แจ้งเตือน UI ให้อัปเดต
    });
  }

  // ฟังก์ชันสำหรับดึงโปรไฟล์ของเพื่อนจาก Firestore
  Future<Map<String, dynamic>> fetchUserProfile(String userId) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc.data()!;
    } else {
      return {}; // ถ้าไม่พบโปรไฟล์ก็ส่งกลับเป็นแผนที่ว่าง
    }
  }

  // ✅ ฟังก์ชันสำหรับตั้งค่าการกรองภาพตามเพื่อนที่เลือก
  void setFilter(String friendId) {
    filterBy = friendId;
    notifyListeners(); // อัปเดต UI
  }

  // ✅ ฟังก์ชันเคลียร์ตัวกรอง เพื่อกลับไปแสดงรูปทั้งหมด
  void clearFilter() {
    filterBy = null;
    notifyListeners();
  }
}

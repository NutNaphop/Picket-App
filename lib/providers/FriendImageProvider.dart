import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';

class ImageFriendProvider with ChangeNotifier {
  bool _isLoading = true;
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _imgFriendStream;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allImages = [];
  String? _filterBy; // ตัวแปรสำหรับเก็บ ID ของเพื่อนที่เลือก

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get images {
    // ✅ ถ้ามีการกรอง จะแสดงเฉพาะรูปของเพื่อนที่เลือก
    if (_filterBy != null) {
      return _allImages.where((img) => img.data()["by"] == _filterBy).toList();
    }
    return _allImages;
  }

  bool get isLoading => _isLoading;

  ImageFriendProvider() {
    fetchImages();
  }

  void fetchImages() {
    getImageFriend().listen((newImages) {
      _allImages = newImages;
      _isLoading = false;
      notifyListeners(); // 🔥 แจ้งเตือน UI ให้อัปเดต
    });
  }

  // ✅ ฟังก์ชันสำหรับตั้งค่าการกรองภาพตามเพื่อนที่เลือก
  void setFilter(String friendId) {
    _filterBy = friendId;
    notifyListeners(); // อัปเดต UI
  }

  // ✅ ฟังก์ชันเคลียร์ตัวกรอง เพื่อกลับไปแสดงรูปทั้งหมด
  void clearFilter() {
    _filterBy = null;
    notifyListeners();
  }
}

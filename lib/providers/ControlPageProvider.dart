import 'package:flutter/material.dart';

class ControlPageProvider with ChangeNotifier {
  final PageController _pageController = PageController();
  
  PageController get pageController => _pageController;

  void jumpPage(int index) {
    if (!_pageController.hasClients) return; // ✅ ป้องกัน error ถ้า pageView ยังไม่ถูกสร้าง
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300), // ✅ ใช้ transition ลื่นๆ
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


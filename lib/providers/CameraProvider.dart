import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  final List<CameraDescription> cameras;

  CameraProvider({required this.cameras});

  CameraController? get controller => _controller;
  bool get isCameraInitialized => _isCameraInitialized;

  Future<void> initializeCamera() async {
    if (_isCameraInitialized || _controller != null) {
      print("Camera is already initialized");
      return; // ✅ ป้องกันการเปิดซ้ำซ้อน
    }

    CameraDescription? frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.isNotEmpty
          ? cameras.first
          : throw Exception("No cameras available"),
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await _controller!.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // ฟังก์ชันเพื่อสลับกล้องหน้า-หลัง
  Future<void> switchSideCamera() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print("Camera not initialized");
      return;
    }

    await disposeCamera(); // ✅ ปิดกล้องเก่าก่อน

    // หาค่ากล้องที่ไม่เหมือนกับกล้องปัจจุบัน
    CameraDescription newCamera = cameras.firstWhere(
      (camera) =>
          camera.lensDirection != _controller!.description.lensDirection,
      orElse: () => throw Exception("No other camera available"),
    );

    _controller = CameraController(
      newCamera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await _controller!.initialize();
      notifyListeners();
    } catch (e) {
      print("Error switching camera: $e");
    }
  }

  Future<void> disposeCamera() async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.dispose();
      _controller = null;
      _isCameraInitialized = false;
      notifyListeners();
    }
  }
}

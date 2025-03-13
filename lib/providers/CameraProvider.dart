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

  Future<void> initializeCamera({bool useFrontCamera = true}) async {
    if (_isCameraInitialized || _controller != null) {
      print("📷 กล้องเปิดอยู่แล้ว");
      return;
    }

    // เลือกกล้องตามเงื่อนไขที่กำหนด
    CameraDescription? selectedCamera;
    if (useFrontCamera) {
      selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.isNotEmpty
            ? cameras.first
            : throw Exception("🚫 ไม่มีกล้องให้ใช้งาน"),
      );
    } else {
      selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.isNotEmpty
            ? cameras.first
            : throw Exception("🚫 ไม่มีกล้องให้ใช้งาน"),
      );
    }

    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      _isCameraInitialized = true;
      notifyListeners();
      print("✅ กล้อง ${selectedCamera.lensDirection} เปิดสำเร็จ");
    } catch (e) {
      print('❌ Error initializing camera: $e');
    }
  }

  // ฟังก์ชันเพื่อสลับกล้องหน้า-หลัง
  Future<void> switchSideCamera() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print("🚫 กล้องยังไม่เปิด");
      return;
    }

    bool isUsingFrontCamera =
        _controller!.description.lensDirection == CameraLensDirection.front;

    await disposeCamera(); // ปิดกล้องเก่า

    // เปิดกล้องใหม่โดยสลับจากกล้องที่ใช้อยู่
    await initializeCamera(useFrontCamera: !isUsingFrontCamera);
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

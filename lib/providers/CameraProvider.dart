import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  final List<CameraDescription> cameras;

  CameraProvider({required this.cameras}) {
    initializeCamera(); // ✅ Initialize here
  }

  CameraController? get controller => _controller;
  bool get isCameraInitialized => _isCameraInitialized;

  // Initialize Camera
  Future<void> initializeCamera() async {
    // Find the front camera.
    CameraDescription? frontCamera;
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }
    if (frontCamera == null && cameras.isNotEmpty) {
      frontCamera = cameras.first ;
    }
    if (frontCamera != null) {
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      try {
        await _controller?.initialize();
        _isCameraInitialized = true;
        notifyListeners();
      } catch (e) {
        print('Error initializing camera: $e');
      }
    } else {
      print('No cameras found');
    }
  }

  // Dispose Camera
  void disposeCamera() {
    if (_controller != null) {
      _controller?.dispose();
      _isCameraInitialized = false;
      notifyListeners();
    }
  }
}

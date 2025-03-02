import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// CameraComponent เป็น Widget สำหรับแสดงกล้อง
class CameraComponent extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraComponent({super.key, required this.cameras});

  @override
  State<CameraComponent> createState() => _CameraComponentState();
}

class _CameraComponentState extends State<CameraComponent> {
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(widget.cameras[1], ResolutionPreset.max);

    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: CameraPreview(_controller),
    );
  }
}

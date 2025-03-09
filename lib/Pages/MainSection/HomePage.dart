import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Frame/CameraView.dart';
import 'package:locket_mockup/components/Frame/FriendFrame.dart';
import 'package:locket_mockup/components/Frame/PreviewFrame.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/ControlPageProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _imgFriendStream;
  String? _imagePath;
  // final PageController _pageController = PageController();
  late Future<List<CameraDescription>> _camerasFuture;

  @override
  void initState() {
    super.initState();
    var camProvider = Provider.of<CameraProvider>(context, listen: false);
    _imgFriendStream = getImageFriend(); // โหลดรูปเพื่อน
    if (!camProvider.isCameraInitialized) {
      print("Start Cam");
      _initCamera();
    }
  }

  void _initCamera() async {
    var camProvider = Provider.of<CameraProvider>(context, listen: false);
    await camProvider.initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<ControlPageProvider>(context, listen: false);
    var camProvider = Provider.of<CameraProvider>(context);
    var _pageController = pageProvider.pageController;

    return Scaffold(
      body: Consumer<ImageFriendProvider>(
        builder: (context, imageProvider, child) {
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: imageProvider.images.length + 1,
            onPageChanged: (index) async {
              if (index == 0) {
                _initCamera();
              } else {
                await camProvider.disposeCamera(); // ปิดกล้องเมื่อเปลี่ยนหน้า
              }
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return Center(
                  child: camProvider.isCameraInitialized &&
                          camProvider.controller != null
                      ? CameraView(
                          controller: camProvider.controller!,
                          initializeControllerFuture:
                              camProvider.controller!.initialize(),
                          onPictureTaken: (imagePath) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PreviewFrame(imagePath: imagePath),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        )
                      : Center(
                          child:
                              CircularProgressIndicator()), // ✅ แสดง loading ถ้ายังไม่พร้อม
                );
              } else {
                var img = imageProvider.images[index - 1].data();
                return FriendFrame(
                    friend_info: img, pageController: _pageController);
              }
            },
          );
        },
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locket_mockup/components/Appbar/CustomAppbar.dart';
import 'package:locket_mockup/components/Frame/CameraView.dart';
import 'package:locket_mockup/components/Frame/FriendFrame.dart';
import 'package:locket_mockup/components/Frame/PreviewFrame.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';

class HomePage extends StatefulWidget {
  final CameraDescription camera;
  
  HomePage({required this.camera});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _imgFriendStream;
  String? _imagePath;
  final PageController _pageController = PageController(); // ✅ PageController

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    _imgFriendStream = getImageFriend(); // รับ Stream ของเพื่อน
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        stream: _imgFriendStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No friends found"));
          }

          var friendList = snapshot.data!;
          return PageView.builder(
            controller: _pageController , 
            scrollDirection: Axis.vertical,
            itemCount: friendList.length + 1, // รวม CameraView ด้วย
            itemBuilder: (context, index) {
              if (index == 0) {
                return Center(
                  child: CameraView(
                    controller: _controller,
                    initializeControllerFuture: _initializeControllerFuture,
                    onPictureTaken: (imagePath) {
                      setState(() {
                        _imagePath = imagePath;
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => PreviewFrame(imagePath: imagePath), transitionDuration: Duration.zero , reverseTransitionDuration: Duration.zero )) ; 
                      });
                    },
                  ),
                );
              } else {
                return FriendFrame(friend_info: friendList[index - 1].data() , pageController: _pageController,);
              }
            },
          );
        },
      ),
    );
  }
}

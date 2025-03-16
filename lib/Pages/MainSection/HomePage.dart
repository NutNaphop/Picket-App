import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';
import 'package:locket_mockup/components/Frame/CameraView.dart';
import 'package:locket_mockup/components/Frame/FriendFrame.dart';
import 'package:locket_mockup/components/Frame/NothingFrame.dart';
import 'package:locket_mockup/components/Frame/PreviewFrame.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/ControlPageProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _initCamera());
  }

  void _initCamera() async {
    var camProvider = Provider.of<CameraProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      camProvider.initializeCamera(); // เรียกใช้ทันที ไม่ต้องหน่วงเวลา
    });
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
    var _selectIndex = 0;

    void ChangeToFriend() async {
      if (camProvider.isCameraInitialized) {
        await camProvider.disposeCamera();
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FriendPage()), // เปลี่ยนเป็นหน้า FriendPage
      );

      if (!camProvider.isCameraInitialized && _pageController.page == 0) {
        await camProvider.initializeCamera();
      }
    }

    void ChangeToSetting() async {
      if (camProvider.isCameraInitialized) {
        await camProvider.disposeCamera();
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingPage()), // เปลี่ยนเป็นหน้า FriendPage
      );

      if (!camProvider.isCameraInitialized && _pageController.page == 0) {
        await camProvider.initializeCamera();
      }
    }

    return Scaffold(
      body: Consumer<ImageFriendProvider>(
        builder: (context, imageProvider, child) {
          return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: imageProvider.images.length + 1,
              onPageChanged: (index) async {
                if (index == 0) {
                  if (!camProvider.isCameraInitialized) {
                    await camProvider.initializeCamera(); // รอให้กล้องพร้อมก่อน
                  }
                } else {
                  // ใช้ Future.microtask เพื่อให้ dispose ไม่ไปกระทบ UI ทันที
                  Future.microtask(() => camProvider.disposeCamera());
                }
              },
              itemBuilder: (context, index) {
                var imgs = imageProvider.images;

                if (index == 0) {
                  return camProvider.isCameraInitialized
                      ? CameraView(
                          controller: camProvider.controller!,
                          initializeControllerFuture:
                              camProvider.initializeCamera(),
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
                          switchSideCamera: () {
                            camProvider.switchSideCamera();
                          },
                        )
                      : Center(child: CircularProgressIndicator());
                }
                if (imgs.isEmpty || (imgs[0].containsKey("noImage"))) {
                  return NothingFrame(
                      pageController: _pageController, index: index);
                } else {
                  var img = imgs[index - 1]; // ตอนนี้มั่นใจว่าไม่ error
                  return FriendFrame(
                    friend_info: img,
                    pageController: _pageController,
                    index: index,
                  );
                }
              });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
      
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              size: 20,
            ),
            label: "Friend",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20,
              ),
              label: "Setting"),
        ],
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.pink[100],
        unselectedItemColor: Colors.pink[100],
        onTap: (value) {
          if (value == 0) {
            ChangeToFriend();
          } else if (value == 1) {
            ChangeToSetting();
          }
        },
      ),
    );
  }
}

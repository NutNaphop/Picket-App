import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/HomePage.dart';
import 'package:locket_mockup/components/Appbar/CustomAppbar.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
// Import หน้า HomePage

class PreviewFrame extends StatefulWidget {
  final String imagePath;

  PreviewFrame({required this.imagePath});

  @override
  State<PreviewFrame> createState() => _PreviewFrameState();
}

class _PreviewFrameState extends State<PreviewFrame> {
  bool isUploading = false;
  bool isUploaded = false;

  void handleUpload() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user_info = userProvider.userData;

    setState(() {
      isUploading = true;
    });

    File file = File(widget.imagePath);

    img.Image? image = img.decodeImage(await file.readAsBytes());

    if (image != null) {
      // 🔄 Flip ภาพแนวนอน (ใช้เฉพาะกับกล้องหน้า)
      img.Image flippedImage = img.flipHorizontal(image);

      // 🔄 แปลงกลับเป็นไฟล์
      file = File(widget.imagePath)
        ..writeAsBytesSync(img.encodeJpg(flippedImage));
    }

    var imgUrl = await uploadImageToCloudinary(file);

    await saveImageFireStore({
      "by": user_info?["uid"],
      "caption": "Hello World",
      "date": DateTime.now(),
      "url": imgUrl,
      "username": user_info?["name"],
    });

    setState(() {
      isUploading = false;
      isUploaded = true;
    });

    // รอ 1 วินาทีเพื่อให้เห็นไอคอนติ๊กถูก
    await Future.delayed(Duration(seconds: 1));

    // TODO : Should call imgProvider to update state
    
    // 🔹 ใช้ PageRouteBuilder เพื่อให้เลื่อนขึ้น
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1), // เริ่มจากข้างล่าง
              end: Offset.zero, // ไปยังตำแหน่งปกติ
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 368,
                  height: 368,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0),
                    child: Image.file(
                      File(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(Icons.close, size: 40, color: Colors.white),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (!isUploading && !isUploaded) handleUpload();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      if (isUploading)
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFF281C1)),
                        )
                      else if (isUploaded)
                        Icon(Icons.check, size: 46, color: Colors.green)
                      else
                        Transform.rotate(
                          angle: 5.5,
                          child: Icon(Icons.send,
                              size: 46, color: Color(0xFFF281C1)),
                        ),
                    ],
                  ),
                ),
                Icon(Icons.draw, size: 40, color: Colors.white),
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 100,
                  child: Column(
                    children: [
                      Icon(Icons.image, size: 30, color: Colors.white),
                      Text(
                        "Upload Your Moments",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

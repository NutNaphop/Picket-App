import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Appbar/CustomAppBarWithFilter.dart';
import 'package:locket_mockup/components/Button/WindowButton.dart';
import 'package:locket_mockup/helper/Dateformat.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class NothingFrame extends StatefulWidget {
  final PageController pageController;
  int index;

  NothingFrame({required this.pageController, required this.index});

  @override
  State<NothingFrame> createState() => _NothingFrameState();
}

class _NothingFrameState extends State<NothingFrame> {
  void initCamera() {
    var camProvider = Provider.of<CameraProvider>(context);
    camProvider.initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithFilter(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              Container(
                width: 368,
                height: 368,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                    Text(
                      "No sended image",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "There is no image here hmmm... Let's take a photo !",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WindowButton(),
                GestureDetector(
                  onTap: () {
                    widget.pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center, // จัดให้ทุกอย่างอยู่ตรงกลาง
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
                      Icon(
                        Icons.favorite,
                        size: 60,
                        color: Color(0xFFF281C1),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.mode_comment_outlined,
                    size: 40, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

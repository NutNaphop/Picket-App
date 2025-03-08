import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendImageListPage.dart';
import 'package:locket_mockup/components/Appbar/CustomAppBarWithFilter.dart';
import 'package:locket_mockup/components/Appbar/CustomAppbar.dart';
import 'package:locket_mockup/components/Button/WindowButton.dart';
import 'package:locket_mockup/helper/Dateformat.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';

class FriendFrame extends StatefulWidget {
  var friend_info;
  final PageController pageController;

  FriendFrame({required this.friend_info, required this.pageController});

  @override
  State<FriendFrame> createState() => _FriendFrameState();
}

class _FriendFrameState extends State<FriendFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithFilter(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                child: Stack(
                  children: [
                    // รูปภาพของเพื่อน
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.friend_info["url"],
                          fit: BoxFit.cover, // ปรับภาพให้พอดี
                        ),
                      ),
                    ),
                    // กล่องข้อความที่อยู่ด้านล่างของรูป
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10, // กำหนดระยะห่างจากขอบล่าง
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                        margin: EdgeInsets.symmetric(horizontal: 70),
                        decoration: BoxDecoration(
                          color: Colors.grey
                              .withValues(alpha: 0.5), // พื้นหลังโปร่งใส
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          widget.friend_info["caption"], // Caption
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 30,
                color: Colors.white,
              ),
              Text(
                widget.friend_info["username"],
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(formatTimestamp(widget.friend_info["date"]),
                  style: TextStyle(color: Colors.grey, fontSize: 16))
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
                Icon(Icons.mode_comment_outlined, size: 40, color: Colors.white),
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 50,
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.image,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "History",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}

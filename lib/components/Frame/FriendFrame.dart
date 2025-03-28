import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Appbar/CustomAppBarWithFilter.dart';
import 'package:locket_mockup/components/Button/WindowButton.dart';
import 'package:locket_mockup/helper/Dateformat.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class FriendFrame extends StatefulWidget {
  var friend_info;
  final PageController pageController;
  int index ; 

  FriendFrame({required this.friend_info, required this.pageController , required this.index});

  @override
  State<FriendFrame> createState() => _FriendFrameState();
  
}

class _FriendFrameState extends State<FriendFrame> {

void initCamera(){
    var camProvider = Provider.of<CameraProvider>(context) ; 
    camProvider.initializeCamera()  ;
}


  @override
  Widget build(BuildContext context) {
    var img_info = widget.friend_info["image"] ; 
    var profile = widget.friend_info["profile"] ; 
    var displayName = widget.friend_info["name"] ; 

    return Scaffold(
      appBar: CustomAppBarWithFilter(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          img_info["url"],
                          fit: BoxFit.cover, // ปรับภาพให้พอดี
                        ),
                      ),
                    ),
                    // กล่องข้อความที่อยู่ด้านล่างของรูป
                    img_info["caption"] != "" ? 
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
                          img_info["caption"], // Caption
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    :
                    SizedBox() 
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
              CircleAvatar(
                backgroundImage: NetworkImage(profile),
                radius: 15,
              ) ,
              Text(
                displayName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(formatTimestamp(img_info["date"]),
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
        ],
      ),
    );
  }
}

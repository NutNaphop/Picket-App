import 'package:flutter/material.dart';
import 'package:locket_mockup/providers/FriendDataProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:provider/provider.dart';

class DropDownFriend extends StatefulWidget {
  const DropDownFriend({super.key});

  @override
  State<DropDownFriend> createState() => _DropDownFriendState();
}

class _DropDownFriendState extends State<DropDownFriend> {
  String? dropdownValue; // ใช้เป็น `null` ก่อนเพื่อรอข้อมูลจาก Provider

  @override
  Widget build(BuildContext context) {
    var friendProvider = Provider.of<FriendProvider>(context);
    var imgProvider = Provider.of<ImageFriendProvider>(context) ; 

    if (friendProvider.friends.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return DropdownButton<String>(
      value: dropdownValue, // ใช้ค่าที่ถูกเลือก
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        // ทำการกรองตาม ID ที่เลือก
        if (newValue != null) {
          // เลือกเพื่อนตาม ID ที่เลือก
          var selectedFriend = friendProvider.friends.firstWhere((friend) => friend["uid"] == newValue);
          imgProvider.setFilter(selectedFriend["uid"]) ; 

          // ส่ง ID เพื่อนให้ Provider เพื่อกรองข้อมูลที่เกี่ยวข้อง
          print('Selected Friend ID: ${selectedFriend["uid"]}');
        }
      },
      items: [
        // แสดง "แสดงทั้งหมด"
        DropdownMenuItem<String>(
          value: null, 
          child: Text("แสดงทั้งหมด"),
        ),
        // สร้างรายการเพื่อนจากข้อมูลที่ดึงมา
        ...friendProvider.friends.map<DropdownMenuItem<String>>((friend) {
          return DropdownMenuItem<String>(
            value: friend["uid"], // ใช้ `uid` เป็น value
            child: Text(friend["name"]), // แสดงชื่อเพื่อน
          );
        }).toList(),
      ],
    );
  }
}

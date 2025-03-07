import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

class ResultListTile extends StatefulWidget {
  Map result_info;

  ResultListTile({required this.result_info});

  @override
  State<ResultListTile> createState() => _ResultListTileState();
}

class _ResultListTileState extends State<ResultListTile> {
  late bool _isAdd; // ใช้เก็บสถานะปุ่มแบบ Local

  @override
  void initState() {
    super.initState();
    _isAdd = false ;// ตรวจสอบสถานะเริ่มต้นจาก API
  }

  void addFriend(String friendId) async {
    bool _isSuccess = await sendFriendRequest(
        {"uid": FirebaseAuth.instance.currentUser!.uid, "name": "Naphop"},
        friendId);

    if (_isSuccess) {
      setState(() {
        _isAdd = true; // อัปเดตสถานะปุ่มใน Local State
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Friend request sent successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send friend request."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget createButton(String status){
    print(status) ;
    if (status == "Pending"){
      return buttonAlreadyAdd() ; 
    } else if (status == "Friend"){
      return buttonFriend() ; 
    }

    return buttonCanAdd() ; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Icon(Icons.account_circle_outlined, size: 40),
        title: Text(
          widget.result_info["name"],
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.result_info["uid"],
          style: TextStyle(fontSize: 12),
        ),
        trailing: SizedBox(
          width: 133,
          child: _isAdd ?  buttonAlreadyAdd() : createButton(widget.result_info["status"]),
        ),
      ),
    );
  }

  Widget buttonCanAdd() {
    return ElevatedButton(
      onPressed: () {
        addFriend(widget.result_info["uid"]);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF65C4B4),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Add friend", style: TextStyle(fontSize: 16)),
          Icon(Icons.add_circle_outline, size: 22, color: Colors.white),
        ],
      ),
    );
  }

  Widget buttonAlreadyAdd() {
    return ElevatedButton(
      onPressed: null, // ปิดการคลิก
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade400,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Added", style: TextStyle(fontSize: 16)),
          Icon(Icons.check, size: 22, color: Colors.white),
        ],
      ),
    );
  }

  Widget buttonFriend() {
    return ElevatedButton(
      onPressed: null, // ปิดการคลิก
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink[200],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Friend", style: TextStyle(fontSize: 16)),
          Icon(Icons.person, size: 22, color: Colors.white),
        ],
      ),
    );
  }
}

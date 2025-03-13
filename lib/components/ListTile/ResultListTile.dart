import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';
import 'package:provider/provider.dart';

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
    _isAdd = false; // ตรวจสอบสถานะเริ่มต้นจาก API
  }

  void addFriend(String friendId) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

     String _isSuccess = await sendFriendRequest(
        {"uid": userProvider.userData?["uid"], "name": userProvider.userData?["name"]},
         friendId);

    if (_isSuccess == "Success") {
      setState(() {
        _isAdd = true; // อัปเดตสถานะปุ่มใน Local State
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Your friend request has been sent', style: TextStyle(
                  color: const Color.fromARGB(255, 28, 181, 89),
                  fontSize: 18,
                ),),
                Icon(Icons.check_circle_outline, color: const Color.fromARGB(255, 28, 181, 89),),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 248, 249, 250),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
      );
    } else {
      String errMsg = _isSuccess == "Max"? "Failed , Your friend list is full": "Failed , Try again" ; 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text(errMsg, style: TextStyle(
                color: const Color.fromARGB(255, 255, 3, 3),
                fontSize: 18,
              ),),
              Icon(Icons.cancel, color: const Color.fromARGB(255, 255, 3, 3),)
              ],),),
          backgroundColor: const Color.fromARGB(255, 254, 254, 254),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
      );
    }
  }

  Widget createButton(String status) {
    print(status);
    if (status == "Pending") {
      return buttonAlreadyAdd();
    } else if (status == "Friend") {
      return buttonFriend();
    }

    return buttonCanAdd();
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
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.result_info["profile"]),
          radius: 20,
        ),
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
          child: _isAdd
              ? buttonAlreadyAdd()
              : createButton(widget.result_info["status"]),
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

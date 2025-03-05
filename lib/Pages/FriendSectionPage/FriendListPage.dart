import 'package:flutter/material.dart';
import 'package:locket_mockup/components/ListTile/FriedListTile.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

List friendList = [
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
  {"name": "Judy Knox", "icon": Icons.account_circle_outlined},
]; 

class _FriendListPageState extends State<FriendListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.white,
            )),
        title: Text("Your Friends",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.diversity_3_rounded,
                size: 120,
                color: Colors.white,
              ),
              Text(
                "Your Friend list",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxHeight: 400, // กำหนดความสูงสูงสุดของ Container
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: friendList.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    Map friend_info = friendList[index];
                    return FriendListTile(friend_info: friend_info);
                  },
                ),
              ),
              SizedBox(height: 30,) , 
              Text(
                "Friend ${friendList.length}/20",
                style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

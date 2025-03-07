import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendListPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendRequestPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/SearchFriendPage.dart';
import 'package:locket_mockup/components/ListTile/SettingMenu.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {

        List friendMenu = [
      {
        "menuText": "Add new friend",
        "icon": Icons.group_add_outlined,
        "onTap": (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFriendPage(),)) ; 
        }
      },
      {
        "menuText": "Your Friends",
        "icon": Icons.diversity_3_rounded,
        "onTap": (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FriendListPage(),)) ; 
        }
      } ,
        {
        "menuText": "Friend requests",
        "icon": Icons.assignment,
        "onTap": (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FriendRequestPage(),)) ; 
        }
      }
    ];




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
        title:
            Text("Friend", style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
         padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Center(
                child: Icon(
              Icons.group,
              size: 100,
              color: Colors.white,
            )) ,
            SizedBox(height: 50,) , 
            Column(
              spacing: 20,
              children: [
                for (var i = 0 ; i < friendMenu.length ; i ++) SettingMenu(menuMap: friendMenu[i])  
              ],
            )
          ],
        ),
      ),
    );
  }
}

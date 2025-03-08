import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ));
          },
          icon: Icon(Icons.account_circle_outlined,
              color: Colors.white, size: 40)),
      backgroundColor: Color(0xFF271943),
      title: Center(
        child: Container(
          width: 140,
          height: 37,
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Picket",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Icon(Icons.favorite, size: 21, color: Colors.pink[200]),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: (){
                        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendPage(),
                  ));
        }, icon: Icon(Icons.group, color: Colors.white, size: 34),) , 
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

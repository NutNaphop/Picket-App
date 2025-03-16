import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var camProvider = Provider.of<CameraProvider>(context);

    void _initializeCamera() async {
      await camProvider.initializeCamera();
    }

    return AppBar(
      backgroundColor: Color(0xFF271943),
      leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.circle, color: Colors.white, size: 30)),
      title: Center(
        child: Container(
          width: 170,
          height: 37,
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text("Picket",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Icon(Icons.favorite, size: 21, color: Colors.pink[100]),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.circle, color: Colors.white, size: 30)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

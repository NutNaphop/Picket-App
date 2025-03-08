import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBarWithFilter extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var camProvider = Provider.of<CameraProvider>(context, listen: false);
    var cameras = availableCameras();

    void _initializeCamera() async {
      var cameras = await availableCameras();
      await camProvider.initializeCamera();
    }

    return AppBar(
      leading: IconButton(
          onPressed: () async {
            camProvider.disposeCamera();
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ));
            _initializeCamera() ; 
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
              Text("Filter",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Icon(Icons.keyboard_arrow_down, size: 21, color: Colors.white),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async{
            camProvider.disposeCamera() ;
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendPage(),
                ));
            _initializeCamera() ; 
          },
          icon: Icon(Icons.group, color: Colors.white, size: 34),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';
import 'package:locket_mockup/components/Dropdown/DropdownFriend.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBarWithFilter extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.circle, color: Colors.white, size: 30)),
      backgroundColor: Color(0xFF271943),
      title: Center(child: DropDownFriend()),
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

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
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SettingPage();
              },
            ));
          },
          icon: Icon(Icons.account_circle_outlined,
              color: Colors.white, size: 40)),
      backgroundColor: Color(0xFF271943),
      title: Center(
        child:  DropDownFriend()
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FriendPage();
              },
            ));
          },
          icon: Icon(Icons.group, color: Colors.white, size: 34),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';

class SettingMenu extends StatefulWidget {
  Map menuMap;

  SettingMenu({required this.menuMap});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.menuMap["onTap"] != null) {
          widget.menuMap["onTap"](context);
        }
      },
      child: ListTile(
        tileColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.42),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Icon(
              widget.menuMap["icon"],
              color: Colors.black,
            )
          ],
        ),
        title: Text(widget.menuMap['menuText']),
        trailing: Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}

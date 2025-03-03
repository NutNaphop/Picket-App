import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.account_circle_outlined, color: Colors.white, size: 40),
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
              Text("Everyone", style: TextStyle(fontSize: 16, color: Colors.white)),
              Icon(Icons.keyboard_arrow_down, size: 21, color: Colors.white),
            ],
          ),
        ),
      ),
      actions: [
        Icon(Icons.group, color: Colors.white, size: 34),
        SizedBox(width: 10),
        Icon(Icons.settings_outlined, color: Colors.white, size: 34),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

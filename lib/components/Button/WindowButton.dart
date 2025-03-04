import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendImageListPage.dart';

class WindowButton extends StatefulWidget {
  const WindowButton({super.key});

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendImageListPage(),
            ));
      },
      child: Icon(
        Icons.window_rounded,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}

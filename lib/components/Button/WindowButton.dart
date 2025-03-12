import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendImageListPage.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:provider/provider.dart';

class WindowButton extends StatefulWidget {
  const WindowButton({super.key});

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> {
  @override
  Widget build(BuildContext context) {
    // final cameraProvider = Provider.of<CameraProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return FriendImageListPage();
              },
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

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/AuthPage.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/ControlPageProvider.dart';
import 'package:locket_mockup/providers/FriendDataProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ControlPageProvider>(
        create: (context) => ControlPageProvider(), 
      ),
      ChangeNotifierProvider<CameraProvider>(
        create: (context) => CameraProvider(cameras: cameras), // 
      ),
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider<FriendProvider>(
        create: (context) => FriendProvider(),
      ),
      ChangeNotifierProvider<ImageFriendProvider>(
        create: (context) => ImageFriendProvider(),
      )
    ],
    child: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Pocket",
        theme: ThemeData(scaffoldBackgroundColor: Color(0xFF271943) , fontFamily: "Inter"),
        home: AuthPage(), 
      );
    });
  }
}

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendRequestPage.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ; 
  final cameras = await availableCameras();
  await Firebase.initializeApp() ; 
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Locket",
    theme: ThemeData(scaffoldBackgroundColor: Color(0xFF271943)),
    // theme: ThemeData(
    //   scaffoldBackgroundColor: Colors.transparent ,
    // ),
    home: LoginPage(),
    // home:  HomePage(camera: cameras[1]),ต
    // home : FriendImageListPage()
    // home: CameraApp(cameras: cameras),
    // home : ForgotPasswordPage()
    // home: Text("data"),
  ));
}





import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/CreateProfilePage.dart';
import 'package:locket_mockup/Pages/ForgotPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendImageListPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendListPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendRequestPage.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/SearchFriendPage.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';
import 'package:locket_mockup/Pages/MainSection/HomePage.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/Pages/RegisterPage.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';


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
    home: WelcomePage(),
    // home:  HomePage(camera: cameras[1]),
    // home : FriendImageListPage()
    // home: CameraApp(cameras: cameras),
    // home : ForgotPasswordPage()
    // home: Text("data"),
  ));
}





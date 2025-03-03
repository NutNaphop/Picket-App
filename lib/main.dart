import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/HomePage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ; 
  final cameras = await availableCameras();
  await Firebase.initializeApp() ; 
  
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Locket",
    theme: ThemeData(scaffoldBackgroundColor: Color(0xFF271943)),
    home:  HomePage(camera: cameras[1],),
    // home: CameraApp(cameras: cameras),
    // home : PreviewFrame() 
    // home: Text("data"),
  ));
}





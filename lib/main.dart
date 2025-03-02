import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/screens/addForm.dart';
import 'package:locket_mockup/screens/HomeScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ; 
  final cameras = await availableCameras();
  await Firebase.initializeApp() ; 
  
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Locket",
    theme: ThemeData(scaffoldBackgroundColor: Color(0xFF271943)),
    home: LoginPage(),
  ));
}





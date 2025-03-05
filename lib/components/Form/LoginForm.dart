import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/HomePage.dart';
import 'package:locket_mockup/screens/HomeScreen.dart';
import 'package:locket_mockup/screens/createUserScreen.dart';
import 'package:locket_mockup/service/auth_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isShowpassword = false ; 

void signUserIn() async {
  // แสดง CircularProgressIndicator
  showDialog(
    context: context,
    barrierDismissible: false, // ป้องกันการปิด dialog โดยการคลิกที่พื้นหลัง
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // ปิด dialog เมื่อล็อกอินสำเร็จ
    Navigator.of(context).pop();

    User? user_cred = userCredential.user;
    var _isExist = await checkUser(user_cred!.uid);
    final cameras = await availableCameras();
    print(_isExist) ;
    var destination = _isExist ? HomePage(camera: cameras[1],): createUserScreen();
    
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => destination));
  } on FirebaseAuthException catch (e) {
    // ปิด dialog เมื่อเกิดข้อผิดพลาด
    Navigator.of(context).pop();
    print('ERROE') ; 
    print(e.code) ; 
    String errorMessage = "Something went wrong, Please try again"; // ข้อความผิดพลาดเริ่มต้น
    if (e.code == 'user-not-found') {
      errorMessage = "Cannot find this user";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Incoorect Password";
    }

    // แสดงข้อความแจ้งเตือน
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 15,
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // กำหนดให้ Text อยู่ทางซ้าย
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your email' ;

                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_isShowpassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: GestureDetector(onTap: (){
                        setState(() {
                          _isShowpassword = !_isShowpassword ; 
                        });
                      }, child: _isShowpassword ? Icon(Icons.visibility): Icon(Icons.visibility_off)),
                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your password';
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUserIn();
                  }
                },
                child: Text(
                  "Log in",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(280, 50)),
                  backgroundColor: WidgetStateProperty.all(Color(0xFFF281C1)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}

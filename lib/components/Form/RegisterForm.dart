import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/components/Snackbars/Snackbar.dart';
import 'package:locket_mockup/helper/ValidatorFunction.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _isShowpassword = false;

  @override
  Widget build(BuildContext context) {
    void signUserUp() async {
      showDialog(
          context: context,
          barrierDismissible: false, // ป้องกันการปิด dialog โดยคลิกที่พื้นหลัง
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      try {
        if (passwordController.text == passwordConfirmController.text) {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          // ปิด dialog
          Navigator.pop(context);

          // แสดงข้อความแจ้งเตือนว่าสร้างบัญชีสำเร็จ
          showSucessSnackbar(context, "Create account successfully!");

          // ตรวจสอบว่าเป็น user ใหม่หรือไม่
          User? user = userCredential.user;
          bool isNewUser = userCredential.additionalUserInfo!.isNewUser;

          await Future.delayed(Duration(seconds: 3));

          if (isNewUser) {
            // ไปที่หน้า createUserScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        } else {
          // แสดงข้อความแจ้งเตือนเมื่อรหัสผ่านไม่ตรงกัน
          showErrorSnackbar(context, "Password does not match!");
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        // ปิด dialog เมื่อเกิดข้อผิดพลาด
        Navigator.pop(context);

        String errorMessage =
            "Something went wrong , Please try again"; // ข้อความผิดพลาดเริ่มต้น
        if (e.code == 'email-already-in-use') {
          errorMessage = "Email already used";
        } else if (e.code == 'weak-password') {
          errorMessage = "Password should be 6 characters long";
        } else if (e.code == 'invalid-email') {
          errorMessage = "Email format is wrong";
        }

        showErrorSnackbar(context, errorMessage);
      }
    }

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
                  autofocus: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "domain@gmail.com",
                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your email';
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
                      hintText: "xxxxxxxxxxx",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isShowpassword = !_isShowpassword;
                            });
                          },
                          child: _isShowpassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  validator: (value) {
                    var pwdValidate = passwordValidator(value!);
                    if (value.isEmpty) return 'Please enter your password';
                    if (pwdValidate != "") {
                      return pwdValidate;
                    }
                    return null;
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: passwordConfirmController,
                  obscureText: !_isShowpassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "xxxxxxxxxxx",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isShowpassword = !_isShowpassword;
                            });
                          },
                          child: _isShowpassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your password';
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Sign UP');
                    signUserUp();
                  }
                },
                child: Text(
                  "Sign Up",
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

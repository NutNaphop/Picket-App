import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/RegisterPage.dart';
import 'package:locket_mockup/components/Form/LoginForm.dart';
import 'package:locket_mockup/components/Resource/Logo/Logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              spacing: 50,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Logo(width: 80, height: 80),
                LoginForm(),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't you have any account",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(color: Color(0xFFF281C1)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

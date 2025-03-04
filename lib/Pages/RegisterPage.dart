import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/components/Form/RegisterForm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Column(
                  spacing: 30,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center, // จัดให้ทุกอย่างอยู่ตรงกลาง
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFF281C1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    RegisterForm(),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Text(
                            "Login here",
                            style: TextStyle(color: Color(0xFFF281C1)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Form/ResetForm.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
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
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
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
                          Icons.question_mark,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    ResetForm() , 
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
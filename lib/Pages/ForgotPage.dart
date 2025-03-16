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
                  spacing: 10,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                      
                      ),
                      textAlign: TextAlign.center,
                    ),
                   Icon(Icons.help_outline , size: 150, color: Colors.white,) , 
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
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/LoginPage.dart';
import 'package:locket_mockup/Pages/RegisterPage.dart';
import 'package:locket_mockup/components/Resource/Logo/Logo.dart';
import 'package:locket_mockup/components/Resource/WelcomeWidget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom: 50),
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeWidget(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Logo(height: 70, width: 70),
                      Text(
                        "Picket",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    child: Text(
                      "Live photo from your friends on your home screen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 30,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(Size(280, 50)),
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xFFF281C1)),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(Size(280, 50)),
                        backgroundColor:
                            WidgetStateProperty.all(Colors.grey[400]),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

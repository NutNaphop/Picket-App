import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/HomePage.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false ;
  
  void checkLoginCache(){
    var user_cache = FirebaseAuth.instance.currentUser;
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    if(user_cache != null){
      userProvider.fetchUserData(user_cache.uid) ; 

      if (userProvider.userData != null){
        setState(() {
          isLogin = true;
        });
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return isLogin ? HomePage() : WelcomePage();
  }
}

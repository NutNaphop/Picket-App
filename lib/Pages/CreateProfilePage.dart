import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/HomePage.dart';
import 'package:locket_mockup/components/BottomSheet/ProfileSheet.dart';
import 'package:locket_mockup/service/CRUD.dart';


class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;

  String profileUrl = "https://api.dicebear.com/9.x/lorelei/jpg?seed=john";

  void setProfile(String selectProfile) {
    if (selectProfile.isNotEmpty) {
      setState(() {
        profileUrl = selectProfile;
      });
    }
  }

  Future<void> handleUserForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> userInfo = {
      "username": _usernameController.text,
      "email": user!.email,
      "uid": user!.uid,
      "url": profileUrl,
    };
    
    try {
      await createUser(userInfo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile created successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2)
        ),
      );

      await Future.delayed(Duration(seconds: 3)) ; 
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, // ลบหน้าทั้งหมดใน stack
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create profile: \$e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: 70),
                Text(
                  "Create Profile",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: NetworkImage(profileUrl),
                  radius: 60,
                ),
                SizedBox(height: 30),
                ProfileSheet(setProfile: setProfile),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter your username",
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : handleUserForm,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(280, 50)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF281C1)),
                      foregroundColor:
                          WidgetStateProperty.all(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
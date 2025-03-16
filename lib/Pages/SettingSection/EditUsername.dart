import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/SettingSection/SettingPage.dart';
import 'package:locket_mockup/components/BottomSheet/ProfileSheet.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:locket_mockup/service/CRUD.dart';
import 'package:provider/provider.dart';

class EditUsernamePage extends StatefulWidget {
  const EditUsernamePage({super.key});

  @override
  State<EditUsernamePage> createState() => _EditUsernamePageState();
}

class _EditUsernamePageState extends State<EditUsernamePage> {
  final _formKey = GlobalKey<FormState>();
  late String profileUrl;
  late TextEditingController _usernameController;
  void setVariable() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user_info = userProvider.userData;
    profileUrl = user_info?["profile"];
    _usernameController = TextEditingController(text: user_info?["name"]);
  }

  @override
  void initState() {
    super.initState();
    setVariable();
  }

  void setProfile(String selectProfile) {
    if (selectProfile.isNotEmpty) {
      setState(() {
        profileUrl = selectProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user_info = userProvider.userData;
    bool _isLoading = false;

    print(user_info);

    void handleUpdateSubmit() async {
      if (!_formKey.currentState!.validate()) return;
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> user = {
        "uid": user_info?["uid"],
        "name": _usernameController.text,
        "profile": profileUrl,
      };

      try {
        await updateUser(user);

        user.addAll({
          "friends_request": user_info?["friends_request"],
          "friends": user_info?["friends"],
        });

        userProvider.updateUserData(user);

        // บังคับให้ UI อัปเดตทันที
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Profile updated successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2)),
        );

        await Future.delayed(Duration(seconds: 3));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update profile: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.white,
            )),
        title: Text("Edit Profile",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(profileUrl),
                  radius: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileSheet(setProfile: setProfile),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit your username",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
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
                          if (value!.isEmpty)
                            return 'Please enter your username';
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 320,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleUpdateSubmit();
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(280, 50)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF281C1)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Saved Change",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

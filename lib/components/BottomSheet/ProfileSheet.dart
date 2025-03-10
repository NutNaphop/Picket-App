import 'dart:math';
import 'package:flutter/material.dart';

class ProfileSheet extends StatefulWidget {
  Function(String) setProfile;
  ProfileSheet({required this.setProfile});

  @override
  State<ProfileSheet> createState() => _ProfilesheetState();
}

class _ProfilesheetState extends State<ProfileSheet> {
  List<String> getRandomProfile() {
    var rng = Random();
    List<String> profileList = [];
    for (var i = 0; i < 12; i++) {
      var nextNum = rng.nextInt(100);
      String url =
          "https://api.dicebear.com/9.x/lorelei/jpg?seed=${nextNum.toString()}";
      profileList.add(url);
    }
    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            List<String> profiles =
                getRandomProfile(); // สร้างรายการโปรไฟล์ครั้งแรก
            return StatefulBuilder(
              // ใช้ StatefulBuilder เพื่อให้ setState ทำงานได้
              builder: (context, setState) {
                return Container(
                  width: double.infinity,
                  height: 500, // กำหนดความสูงเพื่อให้ GridView แสดงผลได้
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 20,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 50,
                      ),
                      Text(
                        "Choose your Profile",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            profiles =
                                getRandomProfile(); // อัปเดตโปรไฟล์ใน bottom sheet
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Color(0xFFF281C1)),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        icon: Icon(
                          Icons.shuffle,
                          color: Colors.white,
                        ),
                        label: Text("Random New Profile"),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: profiles.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                widget.setProfile(profiles[index]);
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(profiles[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Color(0xFFF281C1)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      child: Text("Choose your new Profile"),
    );
  }
}

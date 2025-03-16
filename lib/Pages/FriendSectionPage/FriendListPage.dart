import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/SearchFriendPage.dart';
import 'package:locket_mockup/components/Form/SearchUsernameForm.dart';
import 'package:locket_mockup/components/ListTile/FriedListTile.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  List<Map<String, dynamic>> tempList = []; // เก็บเพื่อนทั้งหมด
  List<Map<String, dynamic>> filteredList = []; // เก็บเพื่อนที่ผ่านการกรอง

  final user = FirebaseAuth.instance.currentUser;
  var friendCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void updateSearchResults(String query) {
      setState(() {
        filteredList = tempList
            .where((user) =>
                user["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }

    void handleDelete(String id) {
      deleteFriend(id, user!.uid);
      setState(() {
        tempList.removeWhere((req) => req["uid"] == id); // ลบจาก tempList
        filteredList = List.from(tempList); // รีเซ็ต filteredList ใหม่
      });
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
        title: Text("Your Friends",
            style: TextStyle(fontSize: 24, color: Colors.white , fontFamily: "Josefin Sans" , fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.diversity_3_rounded,
                  size: 120,
                  color: Colors.white,
                ),
                SearchUsernameForm(onSearch: updateSearchResults),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxHeight: 400, // กำหนดความสูงสูงสุดของ Container
                  ),
                  child: StreamBuilder(
                      stream: getFriendList(user),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        tempList = snapshot.data!;

                        if (tempList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  spacing: 5,
                                  children: [
                                    Text(
                                        "Hm... There are no any people in here" ,style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                    Text("Let's add some friend !!!" , style: TextStyle(fontSize: 18)),
                                    Text("Tap at the magnifying glass" , style: TextStyle(fontSize: 18)),
                                  ],
                                ),

                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFriendPage(),)) ; 
                                }, icon: Icon(Icons.search , size: 150, color: Color(0xFF271943),))
                              ],
                            ),
                          );
                        }

                        filteredList =
                            filteredList.isEmpty ? tempList : filteredList;

                        // อัปเดตจำนวนเพื่อน
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            friendCount = tempList.length;
                          });
                        });

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: filteredList.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            Map friend_info = filteredList[index];
                            return FriendListTile(
                              friend_info: friend_info,
                              deleteFriend: handleDelete,
                            );
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Your Friend list",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "Friend ${friendCount}/20",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Form/SearchUsernameForm.dart';
import 'package:locket_mockup/components/ListTile/ResultListTile.dart';
import 'package:locket_mockup/service/CRUD.dart';

class SearchFriendPage extends StatefulWidget {
  const SearchFriendPage({super.key});

  @override
  State<SearchFriendPage> createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  List tempList = []; // เก็บเพื่อนทั้งหมด
  List filteredList = []; // เก็บเพื่อนที่ผ่านการกรอง

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    filteredList = tempList; // เริ่มต้นให้แสดงผลลัพธ์ทั้งหมด
  }

  void updateSearchResults(String query) {
    setState(() {
      filteredList = tempList
          .where((user) =>
              user["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_outlined,
              size: 20, color: Colors.white),
        ),
        title: Text("Add new friend",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Icon(Icons.group_add_outlined,
                        size: 100, color: Colors.white),
                    SizedBox(height: 20),

                    // ✨ ส่งฟังก์ชันอัปเดตการค้นหาไปให้ SearchUsernameForm
                    SearchUsernameForm(onSearch: updateSearchResults),

                    SizedBox(height: 20),

                    Container(
                      constraints: BoxConstraints(maxHeight: 500),
                      child: FutureBuilder(
                        future: getListOfUser(user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            tempList = snapshot.data!;
                            filteredList =
                                filteredList.isEmpty ? tempList : filteredList;

                            return ListView.separated(
                              itemCount: filteredList.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                var result_info = filteredList[index];
                                return ResultListTile(result_info: result_info);
                              },
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

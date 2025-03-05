import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Form/SearchUsernameForm.dart';
import 'package:locket_mockup/components/ListTile/ResultListTile.dart';

class SearchFriendPage extends StatefulWidget {
  const SearchFriendPage({super.key});

  @override
  State<SearchFriendPage> createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  List resultList = [
    {
      "name": "Judy Knoxxxxxxxxxxxxxxxxxxxxxx",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
    {
      "name": "Judy Knox",
      "icon": Icons.account_circle_outlined,
      "id" : "lXKBgwpVQTMhM82w44XCIZptFIl1" , 
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Icon(
                    Icons.group_add_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SearchUsernameForm(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 500, // กำหนดความสูงสูงสุดของ Container
                    ),
                    child: ListView.separated(
                      itemCount: resultList.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(height: 10) , 
                      itemBuilder: (context, index) {
                        var result_info = resultList[index];
                        return ResultListTile(
                          result_info: result_info,
                        );
                      },
                    ),
                  )
                  // ResultListTile()
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

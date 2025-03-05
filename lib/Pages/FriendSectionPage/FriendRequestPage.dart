import 'package:flutter/material.dart';
import 'package:locket_mockup/components/ListTile/RequestListTile.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {

  List requestList = [
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
    {
      "id" : "aa" , 
      "icon" : Icons.account_circle , 
      "name" : "Naphop" , 
    } , 
  ] ;



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
        title: Text("Friend Request",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.group,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  "You got ${requestList.length} requests",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(
                  height: 20,
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
                    maxHeight: 500, // กำหนดความสูงสูงสุดของ Container
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: requestList.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      Map friend_info = requestList[index];
                      return RequestListTile();
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

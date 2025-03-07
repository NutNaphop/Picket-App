import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/components/ListTile/RequestListTile.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
  List<Map<String, dynamic>> request_store = []; // รายการที่ผ่านการกรอง
  int requestCount = 0;

  @override
  void initState() {
    super.initState();
  }

  void handleAcceptEvent(
      String fromUserId, String requestId, bool _isAccept, String friend_name) {
    setState(() {
      request_store.removeWhere((req) => req["rid"] == requestId);
      requestCount = request_store.length;
    });

    if (_isAccept) {
      print("Accepted");
      acceptFriend(
          FirebaseAuth.instance.currentUser!.uid, requestId, fromUserId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have accepted ${friend_name} as a friend!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print("Rejected");
      rejectFriend(requestId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have rejected ${friend_name}'s request!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                  "You got ${requestCount} requests",
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
                  child: StreamBuilder(
                    stream: getFriendRequests(
                        FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var request = snapshot.data!.docs;

                      if (request.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                spacing: 5,
                                children: [
                                  Text(
                                    "The box is empty ...",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("Look like you haven't got a request",
                                      style: TextStyle(fontSize: 18) , textAlign: TextAlign.center,),
                                ],
                              ),
                              Icon(
                                Icons.inbox,
                                size: 150,
                                color: Color(0xFF271943),
                              )
                            ],
                          ),
                        );
                      }

                      // เก็บข้อมูลใน request_store เมื่อข้อมูลเปลี่ยนแปลง
                      request_store = request.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        data["rid"] = doc.id;
                        return data;
                      }).toList();

                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: request_store.length,
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.grey[300], thickness: 1),
                        itemBuilder: (context, index) {
                          var reqInfo = request_store[index];
                          return RequestListTile(
                            req_info: reqInfo,
                            handleAcceptEvent: handleAcceptEvent,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

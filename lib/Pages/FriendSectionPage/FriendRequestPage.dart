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
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'You are now friend with $friend_name',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 28, 181, 89),
                      fontSize: 16.5,
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: const Color.fromARGB(255, 28, 181, 89),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 248, 249, 250),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      );
    } else {
      print("Rejected");
      rejectFriend(requestId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "You have rejected ${friend_name}'s request!",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 3, 3),
                      fontSize: 16.5,
                    ),
                  ),
                  Icon(
                    Icons.cancel,
                    color: const Color.fromARGB(255, 255, 3, 3),
                  )
                ],
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 254, 254, 254),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
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

                      var data = snapshot.data as Map<String, dynamic>;
                      var profile = data["profile"]; // ข้อมูลโปรไฟล์
                      var requestList = data["friend_requests"] as List<Map<String, dynamic>>;

                      // อัปเดต requestCount
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          requestCount = requestList.length;
                        });
                      });

                      if (requestList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "The box is empty ...",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Look like you haven't got a request",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Icon(Icons.inbox,
                                  size: 150, color: Color(0xFF271943))
                            ],
                          ),
                        );
                      }

                      // อัปเดต request_store
                      request_store = requestList;

                      return Column(
                        children: [
                          // แสดงโปรไฟล์ผู้ใช้ที่ด้านบน
                          // แสดงรายการคำขอเป็นเพื่อน
                          Expanded(
                            child: ListView.separated(
                              itemCount: request_store.length,
                              separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey[300], thickness: 1),
                              itemBuilder: (context, index) {
                                var reqInfo = request_store[index];
                                reqInfo["profile"] = profile;
                                return RequestListTile(
                                  req_info: reqInfo,
                                  handleAcceptEvent: handleAcceptEvent,
                                );
                              },
                            ),
                          ),
                        ],
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
